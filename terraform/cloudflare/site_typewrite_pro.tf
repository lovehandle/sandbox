module "zone_typewrite_pro" {
  source = "../../terraform-modules/zone"

  domain                = "typewrite.pro"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_typewrite_pro" {
  zone_id = module.zone_typewrite_pro.id
  proxied = true
  name    = "*.typewrite.pro"
  type    = "CNAME"
  ttl     = 1
  content = "typewrite.pro" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_typewrite_pro_to_typewrite_pro" {
  zone_id = module.zone_typewrite_pro.id

  name        = "redirect"
  description = "redirect [*.]typewrite.pro to www.typewrite.pro"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]typewrite.pro to www.typewrite.pro"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.typewrite.pro"
          }
        }
      }
    }
  ]
}