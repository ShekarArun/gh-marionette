variable "repo_count" {
  type        = number
  description = "Number of copies of resources"
  default     = 1

  validation {
    condition     = var.repo_count < 5
    error_message = "More than 4 repositories not allowed"
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

# variable "varsource" {
#   type        = string
#   description = "Source used to define variables"
#   default     = "variables.tf"
# }
