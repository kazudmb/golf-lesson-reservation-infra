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

module "scheduler" {
  source                    = "./scheduler"
  project                   = var.project
  lambda_arn                = module.lambda.auto_reserve_lesson_lambda_arn
  scheduler_invoke_role_arn = module.iam.scheduler_invoke_lambda_role_arn
}
