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

output "dev-repo-list" {
  value = flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])
}

module "deploy-key" {
  # Run only for dev repos
  for_each  = toset(flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"]))
  source    = "./modules/deploy-key"
  repo_name = each.key
}

module "info-page" {
  source = "./modules/info-page"
  repos  = { for k, v in module.repos : k => v.clone-urls }
}
