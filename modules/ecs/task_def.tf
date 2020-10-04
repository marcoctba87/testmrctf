
locals {
  task_df_name_front = join("-", compact(list("ecs-task_df-front", var.project, var.environment)))
  task_df_name_back = join("-", compact(list("ecs-task_df-back", var.project, var.environment)))

  task_df_front_tags = {
    Name         = upper(local.task_df_name_front),
    Descritption = "Task Def Front ${upper(var.environment)}",
    Function     = "TASK DEFINITION"
  }
  task_df_back_tags = {
    Name         = upper(local.task_df_name_back),
    Descritption = "Task Def Back ${upper(var.environment)}",
    Function     = "TASK DEFINITION"
  }
}

# INPUT VARIAVEIS NO TASK DEF JSON FRONTEND

data "template_file" "template_front" {
  template = file("./modules/ecs/task_def_front.json")
  vars = {
    port                      = var.container_port_front
    image_url                 = "${var.image_url_front}:latest"
    container_name            = local.service_name_front
    log_group_name            = local.service_name_front
    awslogs_region            = var.awslogs_region
  }
}


resource "aws_ecs_task_definition" "ecs_task_df_front" {
  family                   = local.task_df_name_front
  container_definitions    = data.template_file.template_front.rendered
  tags                     = merge(var.default_tags, local.task_df_front_tags)
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu_units_front
  memory                   = var.ecs_task_mem_reservation_front
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  network_mode             = "awsvpc"
}


# INPUT VARIAVEIS NO TASK DEF JSON BACKEND

data "template_file" "template_back" {
  template = file("./modules/ecs/task_def_back.json")
  vars = {
    port                      = var.container_port_back
    image_url                 = "${var.image_url_back}:latest"
    container_name            = local.service_name_back
    log_group_name            = local.service_name_back
    awslogs_region            = var.awslogs_region
  }
}


resource "aws_ecs_task_definition" "ecs_task_df_back" {
  family                   = local.task_df_name_back
  container_definitions    = data.template_file.template_back.rendered
  tags                     = merge(var.default_tags, local.task_df_back_tags)
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu_units_back
  memory                   = var.ecs_task_mem_reservation_back
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  network_mode             = "awsvpc"
}