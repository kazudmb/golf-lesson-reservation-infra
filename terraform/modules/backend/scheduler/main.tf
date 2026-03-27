resource "aws_scheduler_schedule" "auto_reserve_lesson_hourly" {
  name                         = "${var.project}-auto-reserve-lesson-hourly"
  group_name                   = "default"
  schedule_expression          = "cron(0 0-16 * * ? *)"
  schedule_expression_timezone = "Asia/Tokyo"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.lambda_arn
    role_arn = var.scheduler_invoke_role_arn
  }
}
