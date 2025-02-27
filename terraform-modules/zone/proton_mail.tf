resource "cloudflare_dns_record" "txt_proton_mail" {
  count = var.enable_proton_mail ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = var.domain
  type    = "TXT"
  ttl     = 1
  content = "\"v=spf1 include:alias.proton.me ~all\""
}

resource "cloudflare_dns_record" "mx_proton_mail" {
  for_each = var.enable_proton_mail ? {
    0 = { priority = 10, value = "mx1.alias.proton.me" },
    1 = { priority = 20, value = "mx2.alias.proton.me" }
  } : {}

  zone_id  = cloudflare_zone.zone.id
  name     = var.domain
  type     = "MX"
  ttl      = 1
  priority = each.value["priority"]
  content  = each.value["value"]
}

resource "cloudflare_dns_record" "cname_proton_mail_dkim" {
  for_each = var.enable_proton_mail ? {
    0 = { name = "dkim._domainkey", value = "dkim._domainkey.alias.proton.me" },
    1 = { name = "dkim02._domainkey", value = "dkim02._domainkey.alias.proton.me" },
    2 = { name = "dkim03._domainkey", value = "dkim03._domainkey.alias.proton.me" },
  } : {}

  zone_id = cloudflare_zone.zone.id
  name    = each.value["name"]
  type    = "CNAME"
  ttl     = 1
  content = each.value["value"]
}

resource "cloudflare_dns_record" "txt_proton_mail_dmarc" {
  count = var.enable_proton_mail ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = 1
  content = "\"v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s\""
}

resource "cloudflare_dns_record" "txt_base" {
  for_each = var.proton_mail_site_verifications

  zone_id = cloudflare_zone.zone.id
  name    = var.domain
  type    = "TXT"
  ttl     = 1
  content = each.key
}