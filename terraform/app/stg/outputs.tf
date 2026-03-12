output "api_base_url" {
  value = module.backend.api_endpoint
}

output "dynamodb_table" {
  value = module.backend.dynamodb_table_name
}

output "cognito_user_pool_id" {
  value       = module.cognito.user_pool_id
  description = "Cognito User Pool ID"
}

output "cognito_client_id" {
  value       = module.cognito.client_id
  description = "Cognito App Client ID"
}

output "cognito_domain" {
  value       = module.cognito.domain
  description = "Cognito Hosted UI domain prefix"
}

output "gha_infra_role_arn" {
  value       = module.github_oidc.gha_infra_role_arn
  description = "GitHub Actions infra deploy IAM Role ARN"
}

output "gha_backend_role_arn" {
  value       = module.github_oidc.gha_backend_role_arn
  description = "GitHub Actions backend deploy IAM Role ARN"
}
