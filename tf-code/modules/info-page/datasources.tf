data "terraform_remote_state" "repos" {
  backend = "remote"
  config = {
    organization = "gh-marionette-playground"
    workspaces = {
      name = "gh-marionette-auto-deploy-2"
    }
  }
}

data "github_user" "current" {
  username = ""
}
