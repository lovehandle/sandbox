variable "cloudflare_api_token" {
  type        = string
  description = "API token for authenticating with Cloudflare"
  sensitive   = true
}

variable "cloudflare_account_id" {
  type        = string
  description = "The ID of the Cloudflare account to manage"
}
