resource "cloudflare_dns_record" "txt_fastmail" {
  count = var.enable_fastmail ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = var.domain
  type    = "TXT"
  ttl     = 1
  content = "\"v=spf1 include:spf.messagingengine.com ~all\""
}

resource "cloudflare_dns_record" "mx_fastmail" {
  for_each = var.enable_fastmail ? {
    0 = { priority = 10, value = "in1-smtp.messagingengine.com" },
    1 = { priority = 20, value = "in2-smtp.messagingengine.com" }
  } : {}

  zone_id  = cloudflare_zone.zone.id
  name     = var.domain
  type     = "MX"
  ttl      = 1
  priority = each.value["priority"]
  content  = each.value["value"]
}

resource "cloudflare_dns_record" "cname_fastmail_dkim" {
  for_each = var.enable_fastmail ? {
    0 = { name = "fm1._domainkey", value = "fm1.bigbrain.industries.dkim.fmhosted.com" },
    1 = { name = "fm2._domainkey", value = "fm2.bigbrain.industries.dkim.fmhosted.com" },
    2 = { name = "fm3._domainkey", value = "fm3.bigbrain.industries.dkim.fmhosted.com" },
  } : {}

  zone_id = cloudflare_zone.zone.id
  name    = each.value["name"]
  type    = "CNAME"
  ttl     = 1
  content = each.value["value"]
}

resource "cloudflare_dns_record" "txt_fastmail_dmarc" {
  count = var.enable_fastmail ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = 1
  content = "\"v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s; fo=1; rua=mailto:dmarc-report@rynclsnr.com; ruf=mailto:dmarc-report@rynclsnr.com\""
}