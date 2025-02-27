resource "tfe_organization" "org" {
  name  = "lovehandle"
  email = "wet.farm2262@rynclsnr.com"

  # collaborator_auth_policy = "two_factor_mandatory"

  speculative_plan_management_enabled                     = true
}

resource "tfe_organization_default_settings" "org" {
  organization           = tfe_organization.org.name
  default_execution_mode = "remote"
}

resource "tfe_organization_membership" "lovehandle" {
  organization = tfe_organization.org.name
  email        = "wet.farm2262@rynclsnr.com"
}