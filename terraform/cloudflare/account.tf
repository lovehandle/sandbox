resource "cloudflare_account" "account" {
  name = "lovehandle"
  type = "standard"

  settings = {
    enforce_twofactor = true
  }
}