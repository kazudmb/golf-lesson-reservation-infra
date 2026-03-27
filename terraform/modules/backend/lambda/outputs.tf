output "auto_reserve_lesson_lambda_function_name" {
  value       = aws_lambda_function.auto_reserve_lesson.function_name
  description = "Lambda function name for auto_reserve_lesson"
}

output "auto_reserve_lesson_lambda_arn" {
  value       = aws_lambda_function.auto_reserve_lesson.arn
  description = "Lambda ARN for auto_reserve_lesson"
}

output "auto_reserve_lesson_lambda_invoke_arn" {
  value       = aws_lambda_function.auto_reserve_lesson.invoke_arn
  description = "Invoke ARN for auto_reserve_lesson Lambda function"
}
