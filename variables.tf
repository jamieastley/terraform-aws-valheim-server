locals {
  docker_compose_file          = "docker-compose.yml"
  docker_compose_template_path = "templates/docker-compose.tftpl"
  docker_compose_s3_key_path   = "${var.base_s3_key}/scripts/${local.docker_compose_file}"
  init_ec2_template_path       = "templates/init-ec2.tftpl"
}

# AWS provider
variable "aws_provider_region" {
  description = "The AWS region in which to provision resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "aws_provider_access_key_id" {
  description = "The AWS access key ID to use for the AWS provider"
  type        = string
  sensitive   = true
  nullable    = true
}

variable "aws_provider_secret_key" {
  description = "The AWS secret access key to use for the AWS provider"
  type        = string
  sensitive   = true
  nullable    = true
}

# S3
variable "environment" {
  description = "The environment in which the EC2 instance will be provisioned. Value will also be applied as tag to each resource."
  type        = string
}

# EC2
variable "aws_instance_type" {
  description = "The EC2 instance type which will be provisioned"
  type        = string
  nullable    = false
  default     = "t3a.medium"
}

variable "aws_ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
  nullable    = false
}

variable "app_name" {
  description = "The name of the app service that's being deployed. Name will be concatenated into resource names"
  type        = string
  nullable    = false
}

variable "ec2_public_key" {
  description = "The public key to use for the EC2 instance"
  type        = string
  sensitive   = true
}

variable "log_secure_values" {
  description = "Enables or disables the output of secure values"
  type        = bool
  default     = false
}

variable "ec2_username" {
  description = "The user of the EC2 instance"
  type        = string
  sensitive   = true
}

# S3
variable "docker_image" {
  description = "The Docker image to use for the Valheim server"
  type        = string
  default     = "mbround18/valheim:latest"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to use for game data backups"
  type        = string
}

variable "base_s3_key" {
  description = "The base key for files in the S3 bucket for this module"
  type        = string
}

# Valheim config
variable "valheim_world_name" {
  description = "The name of the Valheim world to use"
  type        = string
}

variable "valheim_server_password" {
  description = "The password for the Valheim server"
  type        = string
  sensitive   = true
}

variable "valheim_server_timezone" {
  description = "The timezone for the Valheim server"
  type        = string
  default     = "Australia/Sydney"
}

variable "valheim_hugin_webhook_url" {
  description = "The webhook URL for Hugin"
  type        = string
  sensitive   = true
}

variable "valheim_server_type" {
  description = "The type of Valheim server to create. "
  type        = string
  default     = "ValheimPlus"
  validation {
    condition = contains([
      "ValheimPlus", "BepInEx", "BepInExFull", "Vanilla"
    ], var.valheim_server_type)
    error_message = "The valheim_server_type variable must be either ValheimPlus, BepInEx, BepInExFull, or Vanilla."
  }
}

# DNS/CloudFlare
variable "dns_record_name" {
  description = "The name of the DNS record to create"
  type        = string
}

variable "dns_zone_id" {
  description = "The ID of the zone to create the DNS record in"
  type        = string
  sensitive   = true
}

variable "dns_record_proxied" {
  description = "Whether the DNS record should be proxied by Cloudflare"
  type        = bool
  default     = false
}

variable "dns_record_ttl" {
  description = "The TTL for the DNS record. Defaults to automatic if not set."
  type        = number
  default     = 1
}

# Debug
variable "enable_ssh_access" {
  description = "Sets whether to enable SSH access to the EC2 instance"
  type        = bool
  default     = false
}

# variable "bucket_name" {
#     description = "The name of the S3 bucket to use for game data backups"
#     type        = string
# }
#
# variable "state_key" {
#     description = "The base key for files in the S3 bucket for this module"
#     type        = string
# }
