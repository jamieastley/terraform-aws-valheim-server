terraform {
  backend "s3" {
    # partial configuration
    key     = "terraform/${environment}/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "http" "dev_outbound_ip" {
  // only get IP if `is_local_debug` is true
  count = var.is_local_debug ? 1 : 0
  url   = "https://ipv4.icanhazip.com"
}

module "valheim_server" {
  // TODO: add version tag
  source = "github.com/jamieastley/ec2-terraform-template"

  app_name          = var.app_name
  ssh_key_name      = var.ssh_key_name
  aws_ami           = var.aws_ami
  aws_instance_type = var.aws_instance_type
  aws_region        = var.aws_region
  aws_access_key    = var.aws_access_key
  aws_secret_key    = var.aws_secret_key
  #  S3 setup
  s3_bucket_id      = aws_s3_object.docker_compose.bucket
  s3_folder_path    = var.s3_folder_path

  #  Route53
  hosted_zone_id     = data.aws_route53_zone.hosted_zone.id
  hosted_zone_name   = var.hosted_zone_name
  subdomain_name     = var.subdomain_name
  enable_ssl_staging = var.enable_ssl_staging
  dns_email_address  = var.dns_email_address

  instance_user_data = templatefile("../templates/init-docker.tftpl", {
    bucket        = var.s3_bucket_name
    username      = var.ec2_username
    base_key_path = var.s3_folder_path
  })

  ingress_rules = flatten([
    [

      {
        description      = "HTTP traffic"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      },
      {
        description = "HTTPS traffic"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
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
