output "org_id" {
  description = "the name of the organization"
  value       = tfe_organization.org.name
}

locals {
  workspaces = [
    tfe_workspace.cloudflare,
    tfe_workspace.terraform,
  ]
}

output "workspace_names" {
  description = "a list of all workspace names (does not includes organization name)"
  value       = local.workspaces[*].name
}

output "workspace_ids" {
  description = "a list of all workspace ids"
  value       = local.workspaces[*].id
}

output "workspace_names_to_ids" {
  description = "a map of workspace names to their ids"
  value       = zipmap(local.workspaces[*].name, local.workspaces[*].id)
}