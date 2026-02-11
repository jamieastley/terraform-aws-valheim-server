output "aws_ami" {
  description = "The AMI ID of the created EC2 instance"
  value       = module.valheim.aws_ami
}

output "elastic_ip" {
  value = module.valheim.elastic_ip
}

output "icanhazip" {
  description = "Local IP address"
  value       = length(data.http.dev_outbound_ip) != 0 ? data.http.dev_outbound_ip[0].response_body : "not used"
}
