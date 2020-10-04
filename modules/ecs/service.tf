# 

locals {
  service_name_front = join("-", compact(list("ecs-service-front", var.project, var.environment)))
  service_name_back = join("-", compact(list("ecs-service-back", var.project, var.environment)))

}

# Service do frontend

resource "aws_ecs_service" "ecs_service_front" {
#  depends_on    = [var.listener_https_depends_on]
  name          = local.service_name_front
  cluster       = aws_ecs_cluster.ecs_cluster.name
  desired_count = var.ecs_service_front_desired_count
  launch_type   = "FARGATE"

  network_configuration {
    security_groups  = [var.sg_group]
    subnets          = [var.subnet_a_id, var.subnet_b_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.tg_group_arn_front
    container_name   = local.service_name_front
    container_port   = var.container_port_front
  }
  task_definition = aws_ecs_task_definition.ecs_task_df_front.family
}

# Service do backend

resource "aws_ecs_service" "ecs_service_back" {
#  depends_on    = [var.listener_https_depends_on]
  name          = local.service_name_back
  cluster       = aws_ecs_cluster.ecs_cluster.name
  desired_count = var.ecs_service_back_desired_count
  launch_type   = "FARGATE"

  network_configuration {
    security_groups  = [var.sg_group]
    subnets          = [var.subnet_a_id, var.subnet_b_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.tg_group_arn_back
    container_name   = local.service_name_back
    container_port   = var.container_port_back
  }
  task_definition = aws_ecs_task_definition.ecs_task_df_back.family
}