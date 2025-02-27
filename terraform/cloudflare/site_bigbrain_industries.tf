module "zone_bigbrain_industries" {
  source = "../../terraform-modules/zone"

  domain                = "bigbrain.industries"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_bigbrain_industries" {
  zone_id = module.zone_bigbrain_industries.id
  proxied = true
  name    = "*.bigbrain.industries"
  type    = "CNAME"
  ttl     = 1
  content = "bigbrain.industries" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_bigbrain_industries_to_bigbrain_industries" {
  zone_id = module.zone_bigbrain_industries.id

  name        = "redirect"
  description = "redirect [*.]bigbrain.industries to www.bigbrain.industries"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]bigbrain.industries to www.bigbrain.industries"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.bigbrain.industries"
          }
        }
      }
    }
  ]
}