resource "github_repository" "sandbox" {
  name         = "sandbox"
  description  = "code for my personal infrastructure"
  homepage_url = "https://lovehandle.me"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  has_discussions      = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  allow_update_branch    = true
  delete_branch_on_merge = true
}

resource "github_branch" "sandbox" {
  repository = github_repository.sandbox.name
  branch     = "main"
}

resource "github_branch_default" "sandbox" {
  repository = github_repository.sandbox.name
  branch     = github_branch.sandbox.branch
}

resource "github_repository_ruleset" "sandbox" {
  name        = "main"
  repository  = github_repository.sandbox.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion = true

    required_linear_history = true
    non_fast_forward        = true

    pull_request {}

    required_status_checks {
      strict_required_status_checks_policy = true

      dynamic "required_check" {
        for_each = [
          "Terraform Cloud/lovehandle/cloudflare",
          "Terraform Cloud/lovehandle/github",
          "Terraform Cloud/lovehandle/terraform",
          "validate"
        ]

        content {
          context        = required_check.value
          integration_id = 0
        }
      }
    }
  }
}

resource "github_actions_repository_permissions" "sandbox" {
  repository      = github_repository.sandbox.name
  allowed_actions = "selected"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
    patterns_allowed     = ["terraform-linters/setup-tflint@*"]
  }
}

resource "github_repository_dependabot_security_updates" "sandbox" {
  repository = github_repository.sandbox.id
  enabled    = true
}