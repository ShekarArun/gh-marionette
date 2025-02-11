resource "github_repository" "auto-repo" {
  name        = "tf-autocreate-1"
  description = "Auto created repo through Terraform"
  visibility  = "private"
  auto_init   = true
}
