variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "lambda_arn" {
  description = "Lambda ARN invoked by EventBridge Scheduler"
  type        = string
}

variable "scheduler_invoke_role_arn" {
  description = "IAM role ARN used by EventBridge Scheduler to invoke Lambda"
  type        = string
}
