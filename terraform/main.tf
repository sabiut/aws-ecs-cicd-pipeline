terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Configure these during terraform init
    # bucket         = "your-terraform-state-bucket"
    # key            = "cicd/terraform.tfstate"
    # region         = "ap-southeast-2"
    # dynamodb_table = "terraform-state-locks"
    # encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id

  common_tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Purpose     = "CICD"
    }
  )

  github_repos = {
    frontend = "${var.github_org}/${var.github_frontend_repo}"
    backend  = "${var.github_org}/${var.github_backend_repo}"
  }
}

module "ecr" {
  source = "./modules/ecr"

  project_name              = var.project_name
  environment               = var.environment
  ecr_image_retention_count = var.ecr_image_retention_count
  enable_image_scanning     = var.enable_image_scanning

  tags = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  project_name      = var.project_name
  environment       = var.environment
  github_org        = var.github_org
  github_repos      = local.github_repos
  ecr_frontend_arn  = module.ecr.frontend_repository_arn
  ecr_backend_arn   = module.ecr.backend_repository_arn
  ecs_cluster_name  = var.ecs_cluster_name
  ecs_frontend_service = var.ecs_frontend_service_name
  ecs_backend_service  = var.ecs_backend_service_name

  tags = local.common_tags
}

module "github_secrets" {
  source = "./modules/github-secrets"

  github_frontend_repo = var.github_frontend_repo
  github_backend_repo  = var.github_backend_repo
  aws_region           = var.aws_region
  aws_account_id       = local.account_id
  iam_role_arn         = module.iam.github_actions_role_arn
  ecr_frontend_url     = module.ecr.frontend_repository_url
  ecr_backend_url      = module.ecr.backend_repository_url
  ecs_cluster_name     = var.ecs_cluster_name
  ecs_frontend_service = var.ecs_frontend_service_name
  ecs_backend_service  = var.ecs_backend_service_name
}