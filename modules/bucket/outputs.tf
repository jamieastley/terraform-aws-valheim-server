output "bucket_name" {
  value       = module.s3_storage_bucket.bucket_name
  description = "The name of the S3 bucket that was created."
}

output "bucket_arn" {
  value       = module.s3_storage_bucket.bucket_arn
  description = "The ARN of the S3 bucket that was created."
}
