module "zone_ryanclosner_com" {
  source = "../../terraform-modules/zone"

  domain                = "ryanclosner.com"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_ryanclosner_com" {
  zone_id = module.zone_ryanclosner_com.id
  proxied = true
  name    = "*.ryanclosner.com"
  type    = "CNAME"
  ttl     = 1
  content = "ryanclosner.com" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_ryanclosner_com_to_ryanclosner_com" {
  zone_id = module.zone_ryanclosner_com.id

  name        = "redirect"
  description = "redirect [*.]ryanclosner.com to www.ryanclosner.com"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]ryanclosner.com to www.ryanclosner.com"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.ryanclosner.com"
          }
        }
      }
    }
  ]
}