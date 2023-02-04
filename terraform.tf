terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46.0"
    }

    acme = {
      source  = "vancluever/acme"
      version = "~> 2.5.3"
    }
  }

  required_version = ">= 1.3.0"
}
