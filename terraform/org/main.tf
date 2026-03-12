data "aws_caller_identity" "current" {}

resource "aws_organizations_organization" "this" {
  count       = var.create_organization ? 1 : 0
  feature_set = "ALL"

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_organizations_organization" "current" {
  count = var.create_organization ? 0 : 1
}

locals {
  organization = one(concat(aws_organizations_organization.this[*], data.aws_organizations_organization.current[*]))
  root_id      = coalesce(var.parent_ou_id, local.organization.roots[0].id)
  project_ou   = coalesce(var.base_ou_name, var.project)
}

resource "aws_organizations_organizational_unit" "project" {
  name      = local.project_ou
  parent_id = local.root_id
}

resource "aws_organizations_organizational_unit" "env" {
  for_each  = var.environment_ou_names
  name      = each.value
  parent_id = aws_organizations_organizational_unit.project.id
}

locals {
  env_ou_ids = { for k, v in aws_organizations_organizational_unit.env : k => v.id }
}

resource "aws_organizations_account" "env" {
  for_each = {
    for env, cfg in var.environment_accounts : env => cfg
    if contains(keys(local.env_ou_ids), env)
  }

  name      = each.value.name
  email     = each.value.email
  parent_id = local.env_ou_ids[each.key]
  role_name = coalesce(try(each.value.role_name, null), "OrganizationAccountAccessRole")

  iam_user_access_to_billing = coalesce(try(each.value.iam_user_access_to_billing, null), "ALLOW")
  close_on_deletion          = false

  tags = {
    Project = var.project
    Env     = each.key
  }
}
