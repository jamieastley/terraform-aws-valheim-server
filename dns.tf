resource "cloudflare_dns_record" "dns_record" {
  name    = var.dns_record_name
  type    = "A"
  proxied = var.dns_record_proxied
  zone_id = var.dns_zone_id
  content = module.valheim.elastic_ip
  ttl     = 3600
  tags = [
    "app:${var.app_name}",
    "Environment:${var.environment}"
  ]
}
