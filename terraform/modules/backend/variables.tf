variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "artifact_bucket_name" {
  description = "S3 bucket name for backend deployment artifacts"
  type        = string
}

variable "create_artifact_bucket" {
  description = "Whether to create and manage the backend deployment artifact bucket"
  type        = bool
  default     = true
}

variable "lambda_runtime" {
  description = "Python runtime for Lambda functions"
  type        = string
  default     = "python3.11"
}
