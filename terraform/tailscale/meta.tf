provider "tailscale" {
  tailnet             = "lovehandle.github"
  oauth_client_id     = var.tailscale_oauth_client_id
  oauth_client_secret = var.tailscale_oauth_client_secret
}

terraform {
  cloud {
    organization = "lovehandle"

    workspaces {
      name = "tailscale"
    }
  }

  required_providers {
    tailscale = {
      source = "tailscale/tailscale"
    }
  }
}