module "dynamodb" {
  source  = "./dynamodb"
  project = var.project
}

module "iam" {
  source    = "./iam"
  project   = var.project
  table_arn = module.dynamodb.table_arn
}

module "lambda" {
  source          = "./lambda"
  project         = var.project
  table_name      = module.dynamodb.table_name
  lambda_role_arn = module.iam.lambda_role_arn
  lambda_runtime  = var.lambda_runtime
}
