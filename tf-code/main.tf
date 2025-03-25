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
    github_repository_file.main,
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
  repository = github_repository.auto-repo[each.key].name
  branch     = "main"
  file       = "README.md"
  content = templatefile(
    "templates/readme.tftpl",
    {
      env  = var.env,
      lang = each.value.lang,
      repo = each.key,
    }
  )
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
  # content             = <<-EOT
  #                       # README for auto-repo
  #                       This is a ${var.env} ${each.value.lang} auto created repo
  #                       The repo was created through Terraform for ${each.key} developers
  #                       EOT
}

resource "github_repository_file" "main" {
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

# output "varsource" {
#   value       = var.varsource
#   description = "Source used for variable definition"
# }

# Kept to indicate the purpose of the 'moved' operation
# moved {
#   from = github_repository_file.index
#   to   = github_repository_file.main
# }
