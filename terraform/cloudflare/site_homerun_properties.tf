module "zone_homerun_properties" {
  source = "../../terraform-modules/zone"

  domain                = "homerun.properties"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_homerun_properties" {
  zone_id = module.zone_homerun_properties.id
  proxied = true
  name    = "*.homerun.properties"
  type    = "CNAME"
  ttl     = 1
  content = "homerun.properties" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_homerun_properties_to_homerun_properties" {
  zone_id = module.zone_homerun_properties.id

  name        = "redirect"
  description = "redirect [*.]homerun.properties to www.homerun.properties"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]homerun.properties to www.homerun.properties"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.homerun.properties"
          }
        }
      }
    }
  ]
}