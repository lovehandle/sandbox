provider "github" {
  owner = "lovehandle"
  token = var.github_token
}

terraform {
  cloud {
    organization = "lovehandle"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}