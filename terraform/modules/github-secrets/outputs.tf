output "github_secrets_instructions" {
  description = "Instructions for setting up GitHub secrets"
  value       = local.setup_instructions
}

output "frontend_secrets" {
  description = "Secrets required for frontend repository"
  value = merge(
    local.github_secrets.common,
    local.github_secrets.frontend
  )
  sensitive = true
}

output "backend_secrets" {
  description = "Secrets required for backend repository"
  value = merge(
    local.github_secrets.common,
    local.github_secrets.backend
  )
  sensitive = true
}