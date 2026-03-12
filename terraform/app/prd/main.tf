data "aws_caller_identity" "current" {}

locals {
  project              = var.project
  account_id           = data.aws_caller_identity.current.account_id
  artifact_bucket_name = coalesce(var.artifact_bucket_name, "${var.project}-artifact-${local.account_id}")
  infra_role_name      = coalesce(var.existing_ci_role_name, "${var.project}-gha-ci")
  backend_role_name    = "${var.project}-backend-gha-ci"
}

module "backend" {
  source  = "../../modules/backend"
  project = local.project
}

module "cognito" {
  source                = "../../modules/cognito"
  project               = local.project
  enable_cognito        = var.enable_cognito
  cognito_domain_prefix = var.cognito_domain_prefix
  cognito_callback_urls = var.cognito_callback_urls
  cognito_logout_urls   = var.cognito_logout_urls
  google_client_id      = var.google_client_id
  google_client_secret  = var.google_client_secret
}

module "github_oidc" {
  source                            = "../../modules/github_oidc"
  enable_github_oidc                = var.enable_github_oidc
  existing_github_oidc_provider_arn = var.existing_github_oidc_provider_arn
  github_oidc_thumbprints           = var.github_oidc_thumbprints
  github_owner                      = var.github_owner
  github_repo_infra                 = var.github_repo_infra
  github_repo_backend               = var.github_repo_backend
  infra_role_name                   = local.infra_role_name
  backend_role_name                 = local.backend_role_name
  backend_inline_policy_json        = data.aws_iam_policy_document.github_backend_ci.json
}

data "aws_iam_policy_document" "github_backend_ci" {
  statement {
    sid    = "LambdaDeploy"
    effect = "Allow"
    actions = [
      "lambda:UpdateFunctionCode",
      "lambda:PublishVersion",
      "lambda:UpdateAlias",
      "lambda:CreateAlias",
      "lambda:GetFunction",
      "lambda:ListVersionsByFunction",
      "lambda:GetFunctionConfiguration"
    ]
    resources = [
      "arn:aws:lambda:${var.aws_region}:${local.account_id}:function:*"
    ]
  }

  statement {
    sid    = "ArtifactBucket"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${local.artifact_bucket_name}",
      "arn:aws:s3:::${local.artifact_bucket_name}/*"
    ]
  }
}
