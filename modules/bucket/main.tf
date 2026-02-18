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
      version = "~> 6.33.0"
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

module "s3_storage_bucket" {
  source  = "jamieastley/s3-backend/aws"
  version = "0.6.0"

  bucket_prefix = "${var.app_name}-"
}
