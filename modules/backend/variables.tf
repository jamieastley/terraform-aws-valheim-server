variable "cloudflare_account_id" {
  description = "The Cloudflare account ID where the R2 bucket will be created"
  sensitive   = true
  type        = string
  nullable    = false
}
