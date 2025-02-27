#resource "tfe_workspace_variable_set" "all" {
#  for_each = {
#    for ws in local.workspaces : ws.name => ws.id
#  }
#  
#  workspace_id    = each.value
#  variable_set_id = tfe_variable_set.all.id
#} 