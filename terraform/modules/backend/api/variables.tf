variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "post_golf_lesson_reservation_lambda_invoke_arn" {
  description = "Invoke ARN for POST /employees/{employeeId}/golf-lesson-reservations Lambda function"
  type        = string
}

variable "post_golf_lesson_reservation_lambda_function_name" {
  description = "Function name for POST /employees/{employeeId}/golf-lesson-reservations Lambda function"
  type        = string
}

variable "get_employees_lambda_invoke_arn" {
  description = "Invoke ARN for GET /employees Lambda function"
  type        = string
}

variable "get_employees_lambda_function_name" {
  description = "Function name for GET /employees Lambda function"
  type        = string
}

variable "get_golf_lesson_reservations_lambda_invoke_arn" {
  description = "Invoke ARN for GET /employees/{employeeId}/golf-lesson-reservations Lambda function"
  type        = string
}

variable "get_golf_lesson_reservations_lambda_function_name" {
  description = "Function name for GET /employees/{employeeId}/golf-lesson-reservations Lambda function"
  type        = string
}

variable "get_golf_lesson_reservation_exports_lambda_invoke_arn" {
  description = "Invoke ARN for GET /admin/golf-lesson-reservation-exports Lambda function"
  type        = string
}

variable "get_golf_lesson_reservation_exports_lambda_function_name" {
  description = "Function name for GET /admin/golf-lesson-reservation-exports Lambda function"
  type        = string
}
