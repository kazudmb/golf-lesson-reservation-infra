variable "project" {
  description = "Project name prefix used for tagging and OU naming"
  type        = string
  default     = "golf-lesson-reservation"
}

variable "aws_region" {
  description = "Region for AWS provider (Organizations is effectively global but still requires a region)"
  type        = string
  default     = "ap-northeast-1"
}

variable "create_organization" {
  description = "When true, create (or import) the AWS Organization in this state. Leave false to rely on an existing Organization."
  type        = bool
  default     = false
}

variable "parent_ou_id" {
  description = "Optional parent OU ID. If unset, the root of the Organization is used."
  type        = string
  default     = null
}

variable "base_ou_name" {
  description = "Name of the project-level OU under the root/parent OU. Defaults to project."
  type        = string
  default     = null
}

variable "environment_ou_names" {
  description = "Map of environment keys to OU names."
  type        = map(string)
  default = {
    dev = "dev"
    stg = "stg"
    prd = "prd"
  }
}

variable "environment_accounts" {
  description = "Optional map of environment accounts to create. Keys should match environment_ou_names. Provide email/name to create the account."
  type = map(object({
    email                      = string
    name                       = string
    role_name                  = optional(string, "OrganizationAccountAccessRole")
    iam_user_access_to_billing = optional(string, "ALLOW")
  }))
  default = {}
}
