module "zone_staylocal_app" {
  source = "../../terraform-modules/zone"

  domain                = "staylocal.app"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_staylocal_app" {
  zone_id = module.zone_staylocal_app.id
  proxied = true
  name    = "*.staylocal.app"
  type    = "CNAME"
  ttl     = 1
  content = "staylocal.app" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_staylocal_app_to_staylocal_app" {
  zone_id = module.zone_staylocal_app.id

  name        = "redirect"
  description = "redirect [*.]staylocal.app to www.staylocal.app"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]staylocal.app to www.staylocal.app"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.staylocal.app"
          }
        }
      }
    }
  ]
}