output "dynamodb_table_name" {
  value       = module.dynamodb.table_name
  description = "Name of the DynamoDB table"
}

output "dynamodb_table_arn" {
  value       = module.dynamodb.table_arn
  description = "ARN of the DynamoDB table"
}

output "lambda_role_arn" {
  value       = module.iam.lambda_role_arn
  description = "IAM role ARN used by the Lambda functions"
}

output "lambda_role_name" {
  value       = module.iam.lambda_role_name
  description = "IAM role name used by the Lambda functions"
}

output "scheduler_invoke_lambda_role_arn" {
  value       = module.iam.scheduler_invoke_lambda_role_arn
  description = "IAM role ARN used by EventBridge Scheduler to invoke Lambda"
}

output "artifact_bucket_name" {
  value       = var.artifact_bucket_name
  description = "S3 bucket name for backend deployment artifacts"
}

output "artifact_bucket_arn" {
  value       = "arn:aws:s3:::${var.artifact_bucket_name}"
  description = "ARN of the backend deployment artifact bucket"
}

output "auto_reserve_lesson_lambda_function_name" {
  value       = module.lambda.auto_reserve_lesson_lambda_function_name
  description = "Lambda function name for auto_reserve_lesson"
}

output "auto_reserve_lesson_lambda_invoke_arn" {
  value       = module.lambda.auto_reserve_lesson_lambda_invoke_arn
  description = "Invoke ARN for auto_reserve_lesson Lambda function"
}
