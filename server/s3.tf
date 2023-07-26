data "aws_s3_bucket" "valheim_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_object" "docker_compose" {
  bucket         = data.aws_s3_bucket.valheim_bucket.id
  key            = "${var.s3_folder_path}/docker-compose.yml"
  content_base64 = base64encode(templatefile("${path.module}/scripts/docker-compose.tftpl", {
    image           = var.docker_image
    world_name      = var.valheim_world_name
    server_password = var.valheim_server_password
    timezone        = var.valheim_server_timezone
    webhook_url     = var.valheim_hugin_webhook_url
    server_type     = var.valheim_server_type
  }))
  etag = filemd5("${path.module}/scripts/docker-compose.tftpl")

  lifecycle {
    #    prevent_destroy = true
  }
}
