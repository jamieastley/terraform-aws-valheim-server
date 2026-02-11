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
      version = "~> 6.31.0"
    }
  }
}

locals {
  app_name = "valheim"
}

provider "aws" {
  default_tags {
    tags = {
      "App" : local.app_name
    }
  }
}

module "oidc_policies" {
  source  = "jamieastley/oidc-provider/aws"
  version = "0.4.0"

  aud_claim_url          = "token.actions.githubusercontent.com:aud"
  aud_claim_list         = ["sts.amazonaws.com"]
  iam_role_name          = "tf-${local.app_name}-oidc-role"
  oidc_provider_arn_list = [var.oidc_provider_arn]
  sub_claim_url          = "token.actions.githubusercontent.com:sub"
  sub_claim_list = [
    "repo:jamieastley/terraform-aws-valheim-server:*",
  ]
}
