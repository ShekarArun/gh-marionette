variable "repo_max" {
  type        = number
  description = "Number of repos"
  default     = 2

  validation {
    condition     = var.repo_max < 10
    error_message = "More than 10 repositories not allowed"
  }
}

variable "env" {
  type        = string
  description = "Deployment Environment"

  validation {
    # condition     = var.env == "dev" || var.env == "prd"
    condition     = contains(["dev", "prd"], var.env)
    error_message = "Environment can only be 'dev' or 'prd'"
  }
}

variable "repos" {
  type        = map(map(string))
  description = "Repositories and relevant files"

  validation {
    condition     = length(var.repos) <= var.repo_max
    error_message = "Number of repos exceeds max limit (repo_max) of ${var.repo_max}"
  }
}

# variable "varsource" {
#   type        = string
#   description = "Source used to define variables"
#   default     = "variables.tf"
# }
