resource "cloudflare_dns_record" "dns_record" {
  name    = var.dns_record_name
  type    = "A"
  proxied = var.dns_record_proxied
  zone_id = var.dns_zone_id
  content = module.valheim.elastic_ip
  ttl     = var.dns_record_ttl
}
