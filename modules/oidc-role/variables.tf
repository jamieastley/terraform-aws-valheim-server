variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider to associate with the IAM role."
  sensitive   = true
}
