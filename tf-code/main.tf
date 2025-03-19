# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.repo_count
# }

resource "github_repository" "auto-repo" {
  for_each    = var.repos
  name        = "auto-repo-${each.key}"
  description = "${each.value} repo for auto init"
  visibility  = var.env == "prd" ? "public" : "private"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
  provisioner "local-exec" {
    command = "gh repo clone ${self.name}"
    when    = create
  }
  provisioner "local-exec" {
    command = "rm -rf ${self.name}"
    when    = destroy
  }
  # count       = var.repo_count
  # name        = "tf-autocreate-${random_id.random[count.index].dec}"
  # description = "Auto created repo through Terraform"
}

resource "github_repository_file" "readme" {
  for_each = var.repos
  # count               = var.repo_count
  repository          = github_repository.auto-repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = "This is an auto created repo through Terraform, stage: ${var.env}"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each = var.repos
  # count               = var.repo_count
  repository          = github_repository.auto-repo[each.key].name
  file                = "index.html"
  content             = "This is an HTML file!"
  overwrite_on_create = true
}

output "clone-urls" {
  value = {
    for k, v in github_repository.auto-repo : k => v.ssh_clone_url
  }
  # value       = { for i in github_repository.auto-repo[*] : i.name => i.ssh_clone_url }
  description = "Repo names and URLs"
  sensitive   = false
}

# output "varsource" {
#   value       = var.varsource
#   description = "Source used for variable definition"
# }
