resource "cloudflare_record" "dns_record" {
  name    = var.dns_record_name
  type    = "A"
  proxied = var.dns_record_proxied
  zone_id = var.dns_zone_id
  value   = module.valheim.elastic_ip
}