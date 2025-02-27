module "zone_huddlehub_us" {
  source = "../../terraform-modules/zone"

  domain                = "huddlehub.us"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_huddlehub_us" {
  zone_id = module.zone_huddlehub_us.id
  proxied = true
  name    = "*.huddlehub.us"
  type    = "CNAME"
  ttl     = 1
  content = "huddlehub.us" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_huddlehub_us_to_huddlehub_us" {
  zone_id = module.zone_huddlehub_us.id

  name        = "redirect"
  description = "redirect [*.]huddlehub.us to www.huddlehub.us"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]huddlehub.us to www.huddlehub.us"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.huddlehub.us"
          }
        }
      }
    }
  ]
}