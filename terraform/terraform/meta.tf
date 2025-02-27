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

variable "tfe_token" {
  description = "Terraform Cloud API token"
  sensitive   = true
}