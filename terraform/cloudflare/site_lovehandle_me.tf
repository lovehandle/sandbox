module "zone_lovehandle_me" {
  source = "../../terraform-modules/zone"

  domain                = "lovehandle.me"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_lovehandle_me" {
  zone_id = module.zone_lovehandle_me.id
  proxied = true
  name    = "*.lovehandle.me"
  type    = "CNAME"
  ttl     = 1
  content = "lovehandle.me" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_lovehandle_me_to_lovehandle_me" {
  zone_id = module.zone_lovehandle_me.id

  name        = "redirect"
  description = "redirect [*.]lovehandle.me to www.lovehandle.me"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]lovehandle.me to www.lovehandle.me"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.lovehandle.me"
          }
        }
      }
    }
  ]
}