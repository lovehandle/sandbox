module "zone_themontessoribox_co" {
  source = "../../terraform-modules/zone"

  domain                = "themontessoribox.co"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_themontessoribox_co" {
  zone_id = module.zone_themontessoribox_co.id
  proxied = true
  name    = "*.themontessoribox.co"
  type    = "CNAME"
  ttl     = 1
  content = "themontessoribox.co" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_themontessoribox_co_to_themontessoribox_co" {
  zone_id = module.zone_themontessoribox_co.id

  name        = "redirect"
  description = "redirect [*.]themontessoribox.co to www.themontessoribox.co"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]themontessoribox.co to www.themontessoribox.co"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.themontessoribox.co"
          }
        }
      }
    }
  ]
}