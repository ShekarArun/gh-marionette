resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_count
}

resource "github_repository" "auto-repo" {
  count       = var.repo_count
  name        = "tf-autocreate-${random_id.random[count.index].dec}"
  description = "Auto created repo through Terraform"
  visibility  = var.env == "prd" ? "public" : "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = var.repo_count
  repository          = github_repository.auto-repo[count.index].name
  file                = "README.md"
  content             = "This is an auto created repo through Terraform, stage: ${var.env}"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  count               = var.repo_count
  repository          = github_repository.auto-repo[count.index].name
  file                = "index.html"
  content             = "This is an HTML file!"
  overwrite_on_create = true
}

output "clone-urls" {
  value       = { for i in github_repository.auto-repo[*] : i.name => i.ssh_clone_url }
  description = "Repo names and URLs"
  sensitive   = false
}

# output "varsource" {
#   value       = var.varsource
#   description = "Source used for variable definition"
# }
