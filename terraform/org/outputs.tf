output "management_account_id" {
  description = "AWS account ID running the Organization stack"
  value       = data.aws_caller_identity.current.account_id
}

output "organization_arn" {
  description = "ARN of the AWS Organization"
  value       = local.organization.arn
}

output "root_id" {
  description = "Root (or provided parent) OU ID used for the project OU"
  value       = local.root_id
}

output "project_ou_id" {
  description = "Project-level OU ID"
  value       = aws_organizations_organizational_unit.project.id
}

output "environment_ou_ids" {
  description = "Map of environment keys to OU IDs"
  value       = local.env_ou_ids
}

output "environment_account_ids" {
  description = "Map of environment keys to created account IDs (empty if none requested)"
  value       = { for env, account in aws_organizations_account.env : env => account.id }
}
