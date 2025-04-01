resource "github_repository" "this" {
  name        = "gh_marionette_info_page"
  description = "Repository information for the GitHub Marionette"
  visibility  = "public"
  auto_init   = true
  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
  provisioner "local-exec" {
    when    = create
    command = "gh repo view ${self.name} --web"
  }
}

resource "time_static" "this" {}

resource "github_repository_file" "this" {
  repository = github_repository.this.name
  branch     = "main"
  file       = "index.md"
  content = templatefile(
    "${path.module}/templates/index.tftpl",
    {
      github_username      = data.github_user.current.login
      full_name            = data.github_user.current.name
      personal_description = data.github_user.current.bio
      linkedin_url         = "https://linkedin.com/in/arun-shekar"
      timestamp            = formatdate("YYYY-MM-DD", timestamp())
      current_year         = time_static.this.year
      repos                = var.repos

      # repositories = [
      #   {
      #     name        = "auto-repo-frontend-dev",
      #     environment = "dev",
      #     type        = "frontend",
      #     created_at  = "2025-03-01",
      #     is_active   = true,
      #     has_pages   = false
      #   },
      #   {
      #     name        = "auto-repo-backend-dev",
      #     environment = "dev",
      #     type        = "backend",
      #     created_at  = "2025-03-02",
      #     is_active   = true,
      #     has_pages   = true
      #   },
      #   {
      #     name        = "auto-repo-infra-dev",
      #     environment = "dev",
      #     type        = "infra",
      #     created_at  = "2025-03-03",
      #     is_active   = false,
      #     has_pages   = true
      #   },
      #   {
      #     name        = "auto-repo-frontend-prd",
      #     environment = "prd",
      #     type        = "frontend",
      #     created_at  = "2025-03-15",
      #     is_active   = true,
      #     has_pages   = false
      #   },
      #   {
      #     name        = "auto-repo-backend-prd",
      #     environment = "prd",
      #     type        = "backend",
      #     created_at  = "2025-03-16",
      #     is_active   = true,
      #     has_pages   = true
      #   },
      #   {
      #     name        = "auto-repo-infra-prd",
      #     environment = "prd",
      #     type        = "infra",
      #     created_at  = "2025-03-17",
      #     is_active   = true,
      #     has_pages   = true
      #   }
      # ],

      dev_count      = 3
      prd_count      = 3
      frontend_count = 2
      backend_count  = 2
      infra_count    = 2

      recent_activities = [
        {
          repo_name          = "auto-repo-frontend-dev",
          last_updated       = "2025-03-27",
          action_description = "Updated React dependencies"
        },
        {
          repo_name          = "auto-repo-backend-dev",
          last_updated       = "2025-03-26",
          action_description = "Fixed API endpoint issue"
        },
        {
          repo_name          = "auto-repo-infra-dev",
          last_updated       = "2025-03-25",
          action_description = "Added new resource configurations"
        }
      ]
    }
  )
  overwrite_on_create = true
}
