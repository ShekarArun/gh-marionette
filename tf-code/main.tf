resource "github_repository" "auto-repo" {
  name        = "tf-autocreate-1"
  description = "Auto created repo through Terraform"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  repository          = github_repository.auto-repo.name
  file                = "README.md"
  content             = "This is an auto created repo through Terraform"
  overwrite_on_create = true
}
