resource "random_id" "random" {
  byte_length = 2
  count       = 2
}

resource "github_repository" "auto-repo" {
  count       = 2
  name        = "tf-autocreate-${random_id.random[count.index].dec}"
  description = "Auto created repo through Terraform"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = 2
  repository          = github_repository.auto-repo[count.index].name
  file                = "README.md"
  content             = "This is an auto created repo through Terraform"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  count               = 2
  repository          = github_repository.auto-repo[count.index].name
  file                = "index.html"
  content             = "This is an HTML file!"
  overwrite_on_create = true
}

output "repo-names" {
  value       = github_repository.auto-repo[*].name
  description = "Repo names"
}
