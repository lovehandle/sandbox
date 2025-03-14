terraform {
  cloud {
    organization = "lovehandle"

    workspaces {
      name = "terraform"
    }
  }



  required_providers {
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

provider "tfe" {
  token = var.tfe_token
}