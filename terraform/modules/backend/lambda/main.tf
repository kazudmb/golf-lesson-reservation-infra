locals {
  auto_reserve_lesson_placeholder_content = <<PY
def handler(event, context):
    raise RuntimeError("Placeholder artifact. Deploy real code via backend pipeline.")
PY
}

data "archive_file" "auto_reserve_lesson_placeholder" {
  type                    = "zip"
  output_path             = "${path.module}/auto_reserve_lesson_placeholder.zip"
  source_content          = local.auto_reserve_lesson_placeholder_content
  source_content_filename = "main.py"
}

locals {
  auto_reserve_lesson_package_path = data.archive_file.auto_reserve_lesson_placeholder.output_path
  auto_reserve_lesson_package_hash = data.archive_file.auto_reserve_lesson_placeholder.output_base64sha256
}

resource "aws_lambda_function" "auto_reserve_lesson" {
  function_name = "auto_reserve_lesson"
  role          = var.lambda_role_arn
  handler       = "main.handler"
  runtime       = var.lambda_runtime

  depends_on = [data.archive_file.auto_reserve_lesson_placeholder]

  filename         = local.auto_reserve_lesson_package_path
  source_code_hash = local.auto_reserve_lesson_package_hash

  environment {
    variables = {
      GOLF_LESSON_RESERVATION_TABLE = var.table_name
    }
  }

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}
