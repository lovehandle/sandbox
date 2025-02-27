resource "tfe_variable_set" "all" {
  name         = "All"
  description  = "Variables shared across all workspaces"
  organization = tfe_organization.org.name  # Use the org name instead of hardcoding
} 