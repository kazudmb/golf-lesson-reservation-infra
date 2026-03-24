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

output "api_endpoint" {
  value       = module.api.api_endpoint
  description = "Base URL of the HTTP API"
}

output "artifact_bucket_name" {
  value       = var.artifact_bucket_name
  description = "S3 bucket name for backend deployment artifacts"
}

output "artifact_bucket_arn" {
  value       = "arn:aws:s3:::${var.artifact_bucket_name}"
  description = "ARN of the backend deployment artifact bucket"
}

output "post_golf_lesson_reservation_lambda_function_name" {
  value       = module.lambda.post_golf_lesson_reservation_lambda_function_name
  description = "Lambda function name for POST /employees/{employeeId}/golf-lesson-reservations"
}

output "post_golf_lesson_reservation_lambda_invoke_arn" {
  value       = module.lambda.post_golf_lesson_reservation_lambda_invoke_arn
  description = "Invoke ARN for POST /employees/{employeeId}/golf-lesson-reservations Lambda function"
}

output "get_employees_lambda_function_name" {
  value       = module.lambda.get_employees_lambda_function_name
  description = "Lambda function name for GET /employees"
}

output "get_employees_lambda_invoke_arn" {
  value       = module.lambda.get_employees_lambda_invoke_arn
  description = "Invoke ARN for GET /employees Lambda function"
}

output "get_golf_lesson_reservations_lambda_function_name" {
  value       = module.lambda.get_golf_lesson_reservations_lambda_function_name
  description = "Lambda function name for GET /employees/{employeeId}/golf-lesson-reservations"
}

output "get_golf_lesson_reservations_lambda_invoke_arn" {
  value       = module.lambda.get_golf_lesson_reservations_lambda_invoke_arn
  description = "Invoke ARN for GET /employees/{employeeId}/golf-lesson-reservations Lambda function"
}

output "get_golf_lesson_reservation_exports_lambda_function_name" {
  value       = module.lambda.get_golf_lesson_reservation_exports_lambda_function_name
  description = "Lambda function name for GET /admin/golf-lesson-reservation-exports"
}

output "get_golf_lesson_reservation_exports_lambda_invoke_arn" {
  value       = module.lambda.get_golf_lesson_reservation_exports_lambda_invoke_arn
  description = "Invoke ARN for GET /admin/golf-lesson-reservation-exports Lambda function"
}
