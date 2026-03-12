resource "aws_apigatewayv2_api" "http" {
  name          = "${var.project}-api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_origins = ["*"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_integration" "post_golf_lesson_reservation" {
  api_id                 = aws_apigatewayv2_api.http.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.post_golf_lesson_reservation_lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "get_employees" {
  api_id                 = aws_apigatewayv2_api.http.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.get_employees_lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "get_golf_lesson_reservations" {
  api_id                 = aws_apigatewayv2_api.http.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.get_golf_lesson_reservations_lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "get_golf_lesson_reservation_exports" {
  api_id                 = aws_apigatewayv2_api.http.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.get_golf_lesson_reservation_exports_lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "post_golf_lesson_reservation" {
  api_id    = aws_apigatewayv2_api.http.id
  route_key = "POST /employees/{employeeId}/golf-lesson-reservations"
  target    = "integrations/${aws_apigatewayv2_integration.post_golf_lesson_reservation.id}"
}

resource "aws_apigatewayv2_route" "get_employees" {
  api_id    = aws_apigatewayv2_api.http.id
  route_key = "GET /employees"
  target    = "integrations/${aws_apigatewayv2_integration.get_employees.id}"
}

resource "aws_apigatewayv2_route" "get_golf_lesson_reservations" {
  api_id    = aws_apigatewayv2_api.http.id
  route_key = "GET /employees/{employeeId}/golf-lesson-reservations"
  target    = "integrations/${aws_apigatewayv2_integration.get_golf_lesson_reservations.id}"
}

resource "aws_apigatewayv2_route" "get_golf_lesson_reservation_exports" {
  api_id    = aws_apigatewayv2_api.http.id
  route_key = "GET /admin/golf-lesson-reservation-exports"
  target    = "integrations/${aws_apigatewayv2_integration.get_golf_lesson_reservation_exports.id}"
}

resource "aws_lambda_permission" "api_post_golf_lesson_reservation" {
  statement_id  = "AllowAPIGatewayInvokePost"
  action        = "lambda:InvokeFunction"
  function_name = var.post_golf_lesson_reservation_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_get_employees" {
  statement_id  = "AllowAPIGatewayInvokeGet"
  action        = "lambda:InvokeFunction"
  function_name = var.get_employees_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_get_golf_lesson_reservations" {
  statement_id  = "AllowAPIGatewayInvokeGetRecords"
  action        = "lambda:InvokeFunction"
  function_name = var.get_golf_lesson_reservations_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_get_golf_lesson_reservation_exports" {
  statement_id  = "AllowAPIGatewayInvokeAdminExport"
  action        = "lambda:InvokeFunction"
  function_name = var.get_golf_lesson_reservation_exports_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http.execution_arn}/*/*"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.http.id
  name        = "$default"
  auto_deploy = true
}
