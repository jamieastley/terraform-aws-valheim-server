variable "app_name" {
  description = "The name of the app service that's being deployed. Name will be concatenated into resource names"
  type        = string
  nullable    = false
}

variable "dynamo_table_name" {
  description = "The name of the DynamoDB table to create"
  type        = string
  nullable    = false
}

variable "environment_name" {
  description = "The name of the environment"
  type        = string
  nullable    = false
}

