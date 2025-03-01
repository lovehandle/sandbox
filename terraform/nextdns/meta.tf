
provider "nextdns" {
  api_key = var.nextdns_api_key
}

terraform {
  cloud {
    organization = "lovehandle"

    workspaces {
      name = "nextdns"
    }
  }

  required_providers {
    nextdns = {
      source  = "amalucelli/nextdns"
      version = "0.2.0"
    }
  }
}