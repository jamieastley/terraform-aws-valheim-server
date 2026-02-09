terraform {
  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      "App" = var.app_name
    }
  }
}

module "s3-backend" {
  source  = "jamieastley/s3-backend/aws"
  version = "0.6.0"

  bucket_prefix = "${var.app_name}-"
}
