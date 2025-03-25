output "clone-urls" {
  value = {
    for k, v in github_repository.auto-repo : k => v.ssh_clone_url
  }
  # value       = { for i in github_repository.auto-repo[*] : i.name => i.ssh_clone_url }
  description = "Repo names and URLs"
  sensitive   = false
}

output "current_github_login" {
  value       = data.github_user.current.login
  description = "The user through whom actions are performed"
}
