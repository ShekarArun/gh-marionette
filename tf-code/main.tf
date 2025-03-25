# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.repo_count
# }

resource "github_repository" "auto-repo" {
  for_each    = var.repos
  name        = "auto-repo-${each.key}"
  description = "${each.value.lang} repo for auto init"
  visibility  = var.env == "prd" ? "public" : "private"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
  provisioner "local-exec" {
    command = "rm -rf ${self.name}"
    when    = destroy
  }
  # count       = var.repo_count
  # name        = "tf-autocreate-${random_id.random[count.index].dec}"
  # description = "Auto created repo through Terraform"
}

resource "terraform_data" "repo-clone-provisioner-host" {
  for_each = var.repos
  depends_on = [
    github_repository_file.index,
    github_repository_file.readme
  ]
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.auto-repo[each.key].name}"
    when    = create
  }
}

resource "github_repository_file" "readme" {
  for_each = var.repos
  # count               = var.repo_count
  repository          = github_repository.auto-repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = <<-EOT
                        # README for auto-repo
                        This is a ${var.env} ${each.value.lang} auto created repo
                        The repo was created through Terraform for ${each.key} developers
                        EOT
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

resource "github_repository_file" "index" {
  for_each = var.repos
  # count               = var.repo_count
  repository          = github_repository.auto-repo[each.key].name
  file                = each.value.filename
  content             = "This is an initial file!"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
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

data "github_user" "current" {
  username = ""
}

output "current_github_login" {
  value       = data.github_user.current.login
  description = "The user through whom actions are performed"
}
