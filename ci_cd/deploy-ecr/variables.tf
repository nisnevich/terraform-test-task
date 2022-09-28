variable "env" {
  description = "Working environment."
  default     = "dev"
}

variable "github_repository_branch" {
  description = "Repository branch to pull from."
  default     = "master"
}

variable "github_repository_owner" {
  description = "GitHub repository owner."
  default     = "nisnevich"
}

variable "github_repository_name" {
  description = "GitHub repository name."
  default     = "cinema-microservice"
}

variable "ecr_repository_name" {
  description = "ECR repository to deploy image."
  default     = "eswap_ecr"
}

