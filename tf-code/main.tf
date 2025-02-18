resource "random_id" "random" {
  byte_length = 2
}

resource "github_repository" "auto-repo" {
  name        = "tf-autocreate-${random_id.random.dec}"
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

resource "github_repository_file" "index" {
  repository          = github_repository.auto-repo.name
  file                = "index.html"
  content             = "This is an HTML file!"
  overwrite_on_create = true
}
