output "app_env_name" {
  value       = local.app_env_name
  description = "The concatenated app and environment name"
}

output "bucket_name" {
  value       = local.bucket_name
  description = "The name of the S3 bucket which was created"
}