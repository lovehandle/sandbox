provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

terraform {
  cloud {
    organization = "lovehandle"

    workspaces {
      name = "cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}