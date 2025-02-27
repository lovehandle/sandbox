module "zone_montessoribaby_co" {
  source = "../../terraform-modules/zone"

  domain                = "montessoribaby.co"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_montessoribaby_co" {
  zone_id = module.zone_montessoribaby_co.id
  proxied = true
  name    = "*.montessoribaby.co"
  type    = "CNAME"
  ttl     = 1
  content = "montessoribaby.co" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_montessoribaby_co_to_montessoribaby_co" {
  zone_id = module.zone_montessoribaby_co.id

  name        = "redirect"
  description = "redirect [*.]montessoribaby.co to www.montessoribaby.co"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]montessoribaby.co to www.montessoribaby.co"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.montessoribaby.co"
          }
        }
      }
    }
  ]
}