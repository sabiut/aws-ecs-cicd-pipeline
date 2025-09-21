variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repos" {
  description = "GitHub repositories (frontend and backend)"
  type = object({
    frontend = string
    backend  = string
  })
}

variable "ecr_frontend_arn" {
  description = "ARN of the frontend ECR repository"
  type        = string
}

variable "ecr_backend_arn" {
  description = "ARN of the backend ECR repository"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_frontend_service" {
  description = "Name of the frontend ECS service"
  type        = string
}

variable "ecs_backend_service" {
  description = "Name of the backend ECS service"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}