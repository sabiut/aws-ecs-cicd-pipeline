variable "github_frontend_repo" {
  description = "Frontend repository name"
  type        = string
}

variable "github_backend_repo" {
  description = "Backend repository name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role ARN for GitHub Actions"
  type        = string
}

variable "ecr_frontend_url" {
  description = "ECR frontend repository URL"
  type        = string
}

variable "ecr_backend_url" {
  description = "ECR backend repository URL"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_frontend_service" {
  description = "ECS frontend service name"
  type        = string
}

variable "ecs_backend_service" {
  description = "ECS backend service name"
  type        = string
}