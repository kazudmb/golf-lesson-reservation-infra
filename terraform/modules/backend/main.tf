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
  source           = "./lambda"
  project          = var.project
  table_name       = module.dynamodb.table_name
  lambda_role_arn  = module.iam.lambda_role_arn
  lambda_role_name = module.iam.lambda_role_name
  lambda_runtime   = var.lambda_runtime
}

module "api" {
  source                                                   = "./api"
  project                                                  = var.project
  post_golf_lesson_reservation_lambda_invoke_arn           = module.lambda.post_golf_lesson_reservation_lambda_invoke_arn
  post_golf_lesson_reservation_lambda_function_name        = module.lambda.post_golf_lesson_reservation_lambda_function_name
  get_employees_lambda_invoke_arn                          = module.lambda.get_employees_lambda_invoke_arn
  get_employees_lambda_function_name                       = module.lambda.get_employees_lambda_function_name
  get_golf_lesson_reservations_lambda_invoke_arn           = module.lambda.get_golf_lesson_reservations_lambda_invoke_arn
  get_golf_lesson_reservations_lambda_function_name        = module.lambda.get_golf_lesson_reservations_lambda_function_name
  get_golf_lesson_reservation_exports_lambda_invoke_arn    = module.lambda.get_golf_lesson_reservation_exports_lambda_invoke_arn
  get_golf_lesson_reservation_exports_lambda_function_name = module.lambda.get_golf_lesson_reservation_exports_lambda_function_name
}
