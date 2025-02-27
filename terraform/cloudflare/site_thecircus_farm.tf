module "zone_thecircus_farm" {
  source = "../../terraform-modules/zone"

  domain                = "thecircus.farm"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_thecircus_farm" {
  zone_id = module.zone_thecircus_farm.id
  proxied = true
  name    = "*.thecircus.farm"
  type    = "CNAME"
  ttl     = 1
  content = "thecircus.farm" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_thecircus_farm_to_thecircus_farm" {
  zone_id = module.zone_thecircus_farm.id

  name        = "redirect"
  description = "redirect [*.]thecircus.farm to www.thecircus.farm"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]thecircus.farm to www.thecircus.farm"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.thecircus.farm"
          }
        }
      }
    }
  ]
}