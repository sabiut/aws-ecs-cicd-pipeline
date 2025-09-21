# This module outputs the required GitHub secrets configuration
# GitHub secrets should be manually added or use GitHub CLI/API

locals {
  github_secrets = {
    # Common secrets for both repositories
    common = {
      AWS_REGION     = var.aws_region
      AWS_ACCOUNT_ID = var.aws_account_id
      AWS_ROLE_ARN   = var.iam_role_arn
      ECS_CLUSTER    = var.ecs_cluster_name
    }

    # Frontend-specific secrets
    frontend = {
      ECR_REPOSITORY = var.ecr_frontend_url
      ECS_SERVICE    = var.ecs_frontend_service
    }

    # Backend-specific secrets
    backend = {
      ECR_REPOSITORY = var.ecr_backend_url
      ECS_SERVICE    = var.ecs_backend_service
    }
  }

  # Instructions for setting up GitHub secrets
  setup_instructions = <<-EOT

    ========================================
    GitHub Secrets Setup Instructions
    ========================================

    Add the following secrets to your GitHub repositories:

    Frontend Repository (${var.github_frontend_repo}):
    --------------------------------------------
    AWS_REGION: ${local.github_secrets.common.AWS_REGION}
    AWS_ACCOUNT_ID: ${local.github_secrets.common.AWS_ACCOUNT_ID}
    AWS_ROLE_ARN: ${local.github_secrets.common.AWS_ROLE_ARN}
    ECS_CLUSTER: ${local.github_secrets.common.ECS_CLUSTER}
    ECR_REPOSITORY: ${local.github_secrets.frontend.ECR_REPOSITORY}
    ECS_SERVICE: ${local.github_secrets.frontend.ECS_SERVICE}

    Backend Repository (${var.github_backend_repo}):
    --------------------------------------------
    AWS_REGION: ${local.github_secrets.common.AWS_REGION}
    AWS_ACCOUNT_ID: ${local.github_secrets.common.AWS_ACCOUNT_ID}
    AWS_ROLE_ARN: ${local.github_secrets.common.AWS_ROLE_ARN}
    ECS_CLUSTER: ${local.github_secrets.common.ECS_CLUSTER}
    ECR_REPOSITORY: ${local.github_secrets.backend.ECR_REPOSITORY}
    ECS_SERVICE: ${local.github_secrets.backend.ECS_SERVICE}

    Using GitHub CLI:
    --------------------------------------------
    # For Frontend Repository:
    gh secret set AWS_REGION --body="${local.github_secrets.common.AWS_REGION}" --repo=${var.github_frontend_repo}
    gh secret set AWS_ACCOUNT_ID --body="${local.github_secrets.common.AWS_ACCOUNT_ID}" --repo=${var.github_frontend_repo}
    gh secret set AWS_ROLE_ARN --body="${local.github_secrets.common.AWS_ROLE_ARN}" --repo=${var.github_frontend_repo}
    gh secret set ECS_CLUSTER --body="${local.github_secrets.common.ECS_CLUSTER}" --repo=${var.github_frontend_repo}
    gh secret set ECR_REPOSITORY --body="${local.github_secrets.frontend.ECR_REPOSITORY}" --repo=${var.github_frontend_repo}
    gh secret set ECS_SERVICE --body="${local.github_secrets.frontend.ECS_SERVICE}" --repo=${var.github_frontend_repo}

    # For Backend Repository:
    gh secret set AWS_REGION --body="${local.github_secrets.common.AWS_REGION}" --repo=${var.github_backend_repo}
    gh secret set AWS_ACCOUNT_ID --body="${local.github_secrets.common.AWS_ACCOUNT_ID}" --repo=${var.github_backend_repo}
    gh secret set AWS_ROLE_ARN --body="${local.github_secrets.common.AWS_ROLE_ARN}" --repo=${var.github_backend_repo}
    gh secret set ECS_CLUSTER --body="${local.github_secrets.common.ECS_CLUSTER}" --repo=${var.github_backend_repo}
    gh secret set ECR_REPOSITORY --body="${local.github_secrets.backend.ECR_REPOSITORY}" --repo=${var.github_backend_repo}
    gh secret set ECS_SERVICE --body="${local.github_secrets.backend.ECS_SERVICE}" --repo=${var.github_backend_repo}

    ========================================
  EOT
}