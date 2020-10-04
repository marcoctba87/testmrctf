locals {
  cw_log_tags_front = {
    Name         = local.service_name_front,
    Descritption = "CloudWatch logs Front ${upper(var.environment)}",
    Function     = "CLOUD WATCH LOGS"
  }
  cw_log_tags_back = {
    Name         = local.service_name_back,
    Descritption = "CloudWatch logs Back ${upper(var.environment)}",
    Function     = "CLOUD WATCH LOGS"
  }
}

# CLOUD WATCH LOG GROUP

resource "aws_cloudwatch_log_group" "cw_logs_front" {
  name              = "/ecs/${local.service_name_front}"
  retention_in_days = var.cw_retention_in_days_front
  tags              = merge(var.default_tags, local.cw_log_tags_front)
}


resource "aws_cloudwatch_log_group" "cw_logs_back" {
  name              = "/ecs/${local.service_name_back}"
  retention_in_days = var.cw_retention_in_days_back
  tags              = merge(var.default_tags, local.cw_log_tags_back)
}