module "zone_rynclsnr_com" {
  source = "../../terraform-modules/zone"

  domain                = "rynclsnr.com"
  cloudflare_account_id = cloudflare_account.account.id
  enable_fastmail       = true
}

resource "cloudflare_dns_record" "star_rynclsnr_com" {
  zone_id = module.zone_rynclsnr_com.id
  proxied = true
  name    = "*.rynclsnr.com"
  type    = "CNAME"
  ttl     = 1
  content = "rynclsnr.com" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_rynclsnr_com_to_rynclsnr_com" {
  zone_id = module.zone_rynclsnr_com.id

  name        = "redirect"
  description = "redirect [*.]rynclsnr.com to www.rynclsnr.com"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]rynclsnr.com to www.rynclsnr.com"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "https://www.rynclsnr.com"
          }
        }
      }
    }
  ]
}