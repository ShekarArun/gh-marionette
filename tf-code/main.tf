module "repos" {
  source           = "./modules/dev-repos"
  for_each         = var.environments
  repo_max         = 6
  env              = each.key
  repos            = local.repos
  run_provisioners = false
  # varsource  = "terraform.tfvars"
}

output "repo-info" {
  value = { for k, v in module.repos : k => v.clone-urls }
}

output "dev-repo-list" {
  value = flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])
}

module "deploy-key" {
  # Run only for dev repos
  for_each  = var.deploy_key ? toset(flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])) : []
  source    = "./modules/deploy-key"
  repo_name = each.key
}

module "info-page" {
  source           = "./modules/info-page"
  repos            = { for k, v in module.repos : k => v.clone-urls }
  run_provisioners = false
}
