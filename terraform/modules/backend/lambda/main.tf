locals {
  post_golf_lesson_reservation_placeholder_content = <<PY
def handler(event, context):
    raise RuntimeError("Placeholder artifact. Deploy real code via backend pipeline.")
PY

  get_employees_placeholder_content = <<PY
def handler(event, context):
    raise RuntimeError("Placeholder artifact. Deploy real code via backend pipeline.")
PY

  get_golf_lesson_reservations_placeholder_content = <<PY
def handler(event, context):
    raise RuntimeError("Placeholder artifact. Deploy real code via backend pipeline.")
PY

  get_golf_lesson_reservation_exports_placeholder_content = <<PY
def handler(event, context):
    raise RuntimeError("Placeholder artifact. Deploy real code via backend pipeline.")
PY
}

data "archive_file" "post_golf_lesson_reservation_placeholder" {
  type                    = "zip"
  output_path             = "${path.module}/post_golf_lesson_reservation_placeholder.zip"
  source_content          = local.post_golf_lesson_reservation_placeholder_content
  source_content_filename = "main.py"
}

data "archive_file" "get_employees_placeholder" {
  type                    = "zip"
  output_path             = "${path.module}/get_employees_placeholder.zip"
  source_content          = local.get_employees_placeholder_content
  source_content_filename = "main.py"
}

data "archive_file" "get_golf_lesson_reservations_placeholder" {
  type                    = "zip"
  output_path             = "${path.module}/get_golf_lesson_reservations_placeholder.zip"
  source_content          = local.get_golf_lesson_reservations_placeholder_content
  source_content_filename = "main.py"
}

data "archive_file" "get_golf_lesson_reservation_exports_placeholder" {
  type                    = "zip"
  output_path             = "${path.module}/get_golf_lesson_reservation_exports_placeholder.zip"
  source_content          = local.get_golf_lesson_reservation_exports_placeholder_content
  source_content_filename = "main.py"
}

locals {
  post_golf_lesson_reservation_package_path        = data.archive_file.post_golf_lesson_reservation_placeholder.output_path
  post_golf_lesson_reservation_package_hash        = data.archive_file.post_golf_lesson_reservation_placeholder.output_base64sha256
  get_employees_package_path                       = data.archive_file.get_employees_placeholder.output_path
  get_employees_package_hash                       = data.archive_file.get_employees_placeholder.output_base64sha256
  get_golf_lesson_reservations_package_path        = data.archive_file.get_golf_lesson_reservations_placeholder.output_path
  get_golf_lesson_reservations_package_hash        = data.archive_file.get_golf_lesson_reservations_placeholder.output_base64sha256
  get_golf_lesson_reservation_exports_package_path = data.archive_file.get_golf_lesson_reservation_exports_placeholder.output_path
  get_golf_lesson_reservation_exports_package_hash = data.archive_file.get_golf_lesson_reservation_exports_placeholder.output_base64sha256
}

resource "aws_lambda_function" "post_golf_lesson_reservation" {
  function_name = "post_golf_lesson_reservation"
  role          = var.lambda_role_arn
  handler       = "main.handler"
  runtime       = var.lambda_runtime

  filename         = local.post_golf_lesson_reservation_package_path
  source_code_hash = local.post_golf_lesson_reservation_package_hash

  environment {
    variables = {
      GOLF_LESSON_RESERVATION_TABLE = var.table_name
    }
  }

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_lambda_function" "get_golf_lesson_reservations" {
  function_name = "get_golf_lesson_reservations"
  role          = var.lambda_role_arn
  handler       = "main.handler"
  runtime       = var.lambda_runtime

  filename         = local.get_golf_lesson_reservations_package_path
  source_code_hash = local.get_golf_lesson_reservations_package_hash

  environment {
    variables = {
      GOLF_LESSON_RESERVATION_TABLE = var.table_name
    }
  }

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_lambda_function" "get_golf_lesson_reservation_exports" {
  function_name = "get_golf_lesson_reservation_exports"
  role          = var.lambda_role_arn
  handler       = "main.handler"
  runtime       = var.lambda_runtime

  filename         = local.get_golf_lesson_reservation_exports_package_path
  source_code_hash = local.get_golf_lesson_reservation_exports_package_hash

  environment {
    variables = {
      GOLF_LESSON_RESERVATION_TABLE = var.table_name
    }
  }

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_lambda_function" "get_employees" {
  function_name = "get_employees"
  role          = var.lambda_role_arn
  handler       = "main.handler"
  runtime       = var.lambda_runtime

  filename         = local.get_employees_package_path
  source_code_hash = local.get_employees_package_hash

  environment {
    variables = {
      GOLF_LESSON_RESERVATION_TABLE = var.table_name
    }
  }

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}
