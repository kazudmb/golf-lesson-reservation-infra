output "gha_infra_role_arn" {
  value       = try(aws_iam_role.gha_infra[0].arn, null)
  description = "GitHub Actions infra deploy role ARN"
}

output "gha_backend_role_arn" {
  value       = try(aws_iam_role.gha_backend[0].arn, null)
  description = "GitHub Actions backend deploy role ARN"
}
