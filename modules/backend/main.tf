terraform {
  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80.0"
    }
  }
}

resource "random_uuid" "uuid" {}

locals {
  app_env_name = "${var.app_name}-${var.environment_name}"
  bucket_name  = "${local.app_env_name}-${random_uuid.uuid.result}"
}

module "terraform_backend" {
  source  = "jamieastley/s3-backend/aws"
  version = "0.3.0"

  app_name          = local.app_env_name
  bucket_name       = local.bucket_name
  dynamo_table_name = var.dynamo_table_name
  environment_name  = var.environment_name
}
