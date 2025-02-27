module "zone_wayfarers_guide" {
  source = "../../terraform-modules/zone"

  domain                = "wayfarers.guide"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_wayfarers_guide" {
  zone_id = module.zone_wayfarers_guide.id
  proxied = true
  name    = "*.wayfarers.guide"
  type    = "CNAME"
  ttl     = 1
  content = "wayfarers.guide" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_wayfarers_guide_to_wayfarers_guide" {
  zone_id = module.zone_wayfarers_guide.id

  name        = "redirect"
  description = "redirect [*.]wayfarers.guide to www.wayfarers.guide"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]wayfarers.guide to www.wayfarers.guide"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.wayfarers.guide"
          }
        }
      }
    }
  ]
}