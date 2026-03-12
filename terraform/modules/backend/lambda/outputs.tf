output "post_golf_lesson_reservation_lambda_function_name" {
  value       = aws_lambda_function.post_golf_lesson_reservation.function_name
  description = "Lambda function name for POST /employees/{employeeId}/golf-lesson-reservations"
}

output "post_golf_lesson_reservation_lambda_invoke_arn" {
  value       = aws_lambda_function.post_golf_lesson_reservation.invoke_arn
  description = "Invoke ARN for POST /employees/{employeeId}/golf-lesson-reservations Lambda function"
}

output "get_employees_lambda_function_name" {
  value       = aws_lambda_function.get_employees.function_name
  description = "Lambda function name for GET /employees"
}

output "get_employees_lambda_invoke_arn" {
  value       = aws_lambda_function.get_employees.invoke_arn
  description = "Invoke ARN for GET /employees Lambda function"
}

output "get_golf_lesson_reservations_lambda_function_name" {
  value       = aws_lambda_function.get_golf_lesson_reservations.function_name
  description = "Lambda function name for GET /employees/{employeeId}/golf-lesson-reservations"
}

output "get_golf_lesson_reservations_lambda_invoke_arn" {
  value       = aws_lambda_function.get_golf_lesson_reservations.invoke_arn
  description = "Invoke ARN for GET /employees/{employeeId}/golf-lesson-reservations Lambda function"
}

output "get_golf_lesson_reservation_exports_lambda_function_name" {
  value       = aws_lambda_function.get_golf_lesson_reservation_exports.function_name
  description = "Lambda function name for GET /admin/golf-lesson-reservation-exports"
}

output "get_golf_lesson_reservation_exports_lambda_invoke_arn" {
  value       = aws_lambda_function.get_golf_lesson_reservation_exports.invoke_arn
  description = "Invoke ARN for GET /admin/golf-lesson-reservation-exports Lambda function"
}
