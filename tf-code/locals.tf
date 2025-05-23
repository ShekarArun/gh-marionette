locals {
  repos = {
    "infra" = {
      lang     = "terraform",
      filename = "main.tf",
      pages    = true
    },
    "backend" = {
      lang     = "python",
      filename = "main.py",
      pages    = true
    },
    "frontend" = {
      lang     = "html",
      filename = "index.html",
      pages    = false
    }
  }
}
