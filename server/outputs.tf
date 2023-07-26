output "aws_ami" {
  description = "The AMI ID of the created EC2 instance"
  value       = module.valheim_server.aws_ami
}

output "elastic_ip" {
  value = module.valheim_server.elastic_ip
}

output "icanhazip" {
  value = length(data.http.dev_outbound_ip) != 0 ? data.http.dev_outbound_ip[0].response_body : "not used"
}