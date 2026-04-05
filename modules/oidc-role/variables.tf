variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider to associate with the IAM role."
  sensitive   = true
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account ID that the IAM policies will be applied to."
  sensitive   = true
}

variable "aws_account_region" {
  type        = string
  description = "The AWS region that the IAM policies will be applied to."
  sensitive   = true
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket that the IAM policies will allow access to."
  sensitive   = true
}
