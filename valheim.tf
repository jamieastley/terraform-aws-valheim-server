terraform {
  cloud {

    organization = "jamieastley"

    # https://developer.hashicorp.com/terraform/language/block/terraform#workspaces
    # Depends on TF_WORKSPACE being set via env var
    workspaces {
      tags = ["valheim"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.32.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.16.0"
    }
  }
}

provider "aws" {
  region     = var.aws_provider_region
  access_key = var.aws_provider_access_key_id
  secret_key = var.aws_provider_secret_key
}

data "http" "dev_outbound_ip" {
  // only get IP if `is_local_debug` is true
  count = var.enable_ssh_access ? 1 : 0
  url   = "https://ipv4.icanhazip.com"
}

module "valheim" {
  source  = "jamieastley/ec2-template/aws"
  version = "0.7.0"

  app_name          = var.app_name
  app_description   = "Valheim game server"
  aws_ami           = var.aws_ami
  aws_instance_type = var.aws_instance_type
  environment       = var.environment
  instance_user_data = templatefile(local.init_ec2_template_path, {
    bucket                     = var.s3_bucket_name
    docker_compose_s3_key_path = local.docker_compose_s3_key_path
    app_name                   = var.app_name
    docker_compose_file        = local.docker_compose_file
    username                   = var.ec2_username
  })
  s3_arn_allow_list = [
    "arn:aws:s3:::${var.s3_bucket_name}/${var.base_s3_key}*"
  ]
  ec2_public_key = var.ec2_public_key
  ingress_rules = flatten([
    [
      {
        description      = "Allows Valheim game traffic to the server"
        from_port        = 2456
        to_port          = 2458
        protocol         = "udp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      },
      {
        description      = "Port which will be used to access Hugin"
        from_port        = 3000
        to_port          = 3000
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }
    ],
    length(data.http.dev_outbound_ip) != 0 ? [
      {
        description      = "Allow SSH connections only from the IP address of the developer"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["${chomp(data.http.dev_outbound_ip[0].response_body)}/32"]
        ipv6_cidr_blocks = ["::/0"]
      }
    ] : []
  ])
  egress_rules = [
    {
      description      = "Outbound HTTP"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}
