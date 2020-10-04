variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "default_tags" {
  type = map(string)
}

variable "ecs_service_front_desired_count" {
  type = string
}

variable "ecs_service_back_desired_count" {
  type = string
}

variable "sg_group" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "tg_group_arn_front" {
  type = string
}

variable "tg_group_arn_back" {
  type = string
}

variable "container_port_front" {
  type = string
}

variable "container_port_back" {
  type = string
}

variable "ecs_task_mem_reservation_front" {
  type = string
}

variable "awslogs_region" {
  type = string
}

variable "ecs_task_cpu_units_front" {
  type = string
}

variable "ecs_task_mem_reservation_back" {
  type = string
}

variable "ecs_task_cpu_units_back" {
  type = string
}

variable "image_url_front" {
  type = string
}

variable "image_url_back" {
  type = string
}

variable "cw_retention_in_days_front" {
  type = string
}

variable "cw_retention_in_days_back" {
  type = string
}

variable "aws_alb_depends_on" {
  type = string
}