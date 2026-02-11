variable "app_name" {
  description = "The name of the application. This will be used as a prefix for all resources created by this module."
  type        = string
  nullable    = false
  default     = "valheim"
}