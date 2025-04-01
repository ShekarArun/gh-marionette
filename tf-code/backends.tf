# terraform {
#   backend "local" {
#     path = "../state/terraform.tfstate"
#   }
# }

terraform {
  cloud {

    organization = "gh-marionette-playground"

    workspaces {
      name = "gh-marionette-workspace"
    }
  }
}
