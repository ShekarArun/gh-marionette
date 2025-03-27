locals {
  repos = {
    "infra" = {
      lang     = "terraform",
      filename = "main.tf",
      pages    = true
    },
    "backend" = {
      lang     = "python",
      filename = "main.py",
      pages    = true
    },
    "frontend" = {
      lang     = "html",
      filename = "index.html",
      pages    = false
    }
  }
  environments = toset(["dev", "prd"])
}

module "repos" {
  source   = "./modules/dev-repos"
  for_each = local.environments
  repo_max = 6
  env      = each.key
  # varsource  = "terraform.tfvars"
  repos = local.repos
}

output "repo-info" {
  value = { for k, v in module.repos : k => v.clone-urls }
}
