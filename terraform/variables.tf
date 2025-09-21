variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_frontend_repo" {
  description = "Frontend repository name"
  type        = string
}

variable "github_backend_repo" {
  description = "Backend repository name"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the existing ECS cluster"
  type        = string
}

variable "ecs_frontend_service_name" {
  description = "Name of the frontend ECS service"
  type        = string
  default     = "frontend"
}

variable "ecs_backend_service_name" {
  description = "Name of the backend ECS service"
  type        = string
  default     = "backend"
}

variable "ecr_image_retention_count" {
  description = "Number of images to retain in ECR"
  type        = number
  default     = 10
}

variable "enable_image_scanning" {
  description = "Enable ECR image scanning on push"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}