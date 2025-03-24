repo_max = 3
env      = "dev"
# varsource  = "terraform.tfvars"
repos = {
  "infra" = {
    lang     = "terraform",
    filename = "main.tf"
    }, "backend" = {
    lang     = "python",
    filename = "main.py"
    }, "frontend" = {
    lang     = "html",
    filename = "index.html"
} }
