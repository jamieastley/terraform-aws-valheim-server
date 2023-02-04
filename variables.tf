locals {
  tags = {
    App = var.app_name
    Environment = var.environment
  }

  resource_prefix = "${var.app_name}-${var.environment}"
}

# AWS Account
variable "aws_region" {
  description = "The region in which the EC2 instance will be provisioned"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "The environment in which the EC2 instance will be provisioned. Value will also be applied as tag to each resource."
  type        = string
  default     = "dev"
}

# S3
variable "s3_bucket_id" {
  description = "The ID of the S3 bucket to use for game data"
  type        = string
}

variable "app_name" {
  description = "The name of the app service that's being deployed. Name will be concatenated into resource names"
  type        = string
  nullable    = false
}

# EC2
variable "aws_instance_type" {
  description = "The EC2 instance type which will be provisioned"
  type        = string
  nullable    = false
}

variable "aws_ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
  nullable    = false
}

variable "ssh_key_name" {
  description = "The name of the SSH key that will be used to access the provisioned instance"
  type        = string
}

variable "instance_user_data" {
  description = "User data which will be passed to the provisioned instance"
  type        = any
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "route_table_cidr_block" {
  description = "CIDR block for route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = "A list of ingress rules to apply to the provisioned instance"
  type        = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = optional(list(string))
  }))
}

variable "egress_rules" {
  description = "A list of egress rules to apply to the provisioned instance"
  type        = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = optional(list(string))
  }))
}

variable "enable_ssl_staging" {
  description = "Enable SSL staging for Lets Encrypt"
  type        = bool
  default     = true
}

variable "dns_email_address" {
  description = "Email address to use for SSL certificate"
  type        = string
}

variable "hosted_zone_name" {
  description = "The name of your (existing) hosted zone in AWS (eg. example.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "The ID of your hosted zone in AWS"
  type        = string
}

variable "subdomain_name" {
  description = "The subdomain name which will be used to create the new Route53 record"
  type        = string
}
