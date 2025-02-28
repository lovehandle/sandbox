variable "tailscale_oauth_client_id" {
  description = "The Tailscale OAuth client ID"
  type        = string
}

variable "tailscale_oauth_client_secret" {
  description = "The Tailscale OAuth client secret"
  type        = string
  sensitive   = true
}