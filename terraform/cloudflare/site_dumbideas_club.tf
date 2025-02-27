module "zone_dumbideas_club" {
  source = "../../terraform-modules/zone"

  domain                = "dumbideas.club"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_dumbideas_club" {
  zone_id = module.zone_dumbideas_club.id
  proxied = true
  name    = "*.dumbideas.club"
  type    = "CNAME"
  ttl     = 1
  content = "dumbideas.club" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_dumbideas_club_to_dumbideas_club" {
  zone_id = module.zone_dumbideas_club.id

  name        = "redirect"
  description = "redirect [*.]dumbideas.club to www.dumbideas.club"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]dumbideas.club to www.dumbideas.club"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.dumbideas.club"
          }
        }
      }
    }
  ]
}