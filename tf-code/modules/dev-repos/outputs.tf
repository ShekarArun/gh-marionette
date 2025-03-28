output "clone-urls" {
  value = {
    for k, v in github_repository.auto-repo : v.name => {
      ssh_url   = v.ssh_clone_url
      pages_url = try(v.pages[0].html_url, "N/A")
    }
  }
  # value       = { for i in github_repository.auto-repo[*] : i.name => i.ssh_clone_url }
  description = "Repo names and URLs"
  sensitive   = false
}

output "current_github_login" {
  value       = data.github_user.current.login
  description = "The user through whom actions are performed"
}
