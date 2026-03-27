data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "scheduler_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.project}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

resource "aws_iam_role" "scheduler_invoke_lambda_role" {
  name               = "${var.project}-scheduler-invoke-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.scheduler_assume.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "ddb_rw" {
  statement {
    actions = [
      "dynamodb:PutItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [
      var.table_arn,
      "${var.table_arn}/index/*"
    ]
  }
}

resource "aws_iam_policy" "ddb_rw" {
  name   = "${var.project}-ddb-rw"
  policy = data.aws_iam_policy_document.ddb_rw.json
}

resource "aws_iam_role_policy_attachment" "ddb_rw_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.ddb_rw.arn
}

data "aws_iam_policy_document" "secretsmanager_read" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      "arn:aws:secretsmanager:ap-northeast-1:${data.aws_caller_identity.current.account_id}:secret:auto-reserve-lesson/credentials*"
    ]
  }
}

resource "aws_iam_policy" "secretsmanager_read" {
  name   = "${var.project}-secretsmanager-read"
  policy = data.aws_iam_policy_document.secretsmanager_read.json
}

resource "aws_iam_role_policy_attachment" "secretsmanager_read_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.secretsmanager_read.arn
}

data "aws_iam_policy_document" "scheduler_invoke_lambda" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:auto_reserve_lesson",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:auto_reserve_lesson:*"
    ]
  }
}

resource "aws_iam_policy" "scheduler_invoke_lambda" {
  name   = "${var.project}-scheduler-invoke-lambda"
  policy = data.aws_iam_policy_document.scheduler_invoke_lambda.json
}

resource "aws_iam_role_policy_attachment" "scheduler_invoke_lambda_attach" {
  role       = aws_iam_role.scheduler_invoke_lambda_role.name
  policy_arn = aws_iam_policy.scheduler_invoke_lambda.arn
}
