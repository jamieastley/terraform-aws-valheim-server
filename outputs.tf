output "aws_ami" {
  description = "The AMI ID of the created EC2 instance"
  value       = aws_instance.app_server.ami
}

output "elastic_ip" {
  description = "The Elastic IP assigned to the created EC2 instance"
  value = aws_eip.eip.public_ip
}
