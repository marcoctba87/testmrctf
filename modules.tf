# Variáveis locais global

locals {
  workspace = jsondecode(file("./environments/${terraform.workspace}.json"))

  default_tags = {
    Project     = upper(local.workspace["project_name"])
    Environment = upper(local.workspace["environment"])
  }
}

# Variaveis do modulo VPC

module "vpc" {
  source       = "./modules/vpc"
  project      = local.workspace["project_name"]
  environment  = local.workspace["environment"]
  default_tags = local.default_tags
  vpc_id       = local.workspace["vpc_id"]
  cidr_block_a = local.workspace["cidr_block_a"]
  cidr_block_b = local.workspace["cidr_block_b"]
}

# Variaveis do modulo EC2

module "ec2" {
  source       = "./modules/ec2"
  project      = local.workspace["project_name"]
  environment  = local.workspace["environment"]
  default_tags = local.default_tags
  vpc_id       = local.workspace["vpc_id"]
  sg_alb_cidr_blocks = local.workspace["sg_alb_cidr_blocks"]
  subnet_a_id  = module.vpc.subnet_a_id
  subnet_b_id  = module.vpc.subnet_b_id
}

# Variaveis do modulo ECS

module "ecs" {
  source       = "./modules/ecs"
  project      = local.workspace["project_name"]
  environment  = local.workspace["environment"]
  default_tags = local.default_tags
  sg_group = module.ec2.subnet_sg_id
  tg_group_arn_front = module.ec2.tg_group_arn_front
  tg_group_arn_back = module.ec2.tg_group_arn_back
  subnet_a_id  = module.vpc.subnet_a_id
  subnet_b_id  = module.vpc.subnet_b_id
  ecs_service_front_desired_count = local.workspace["ecs_service_front_desired_count"]
  ecs_service_back_desired_count = local.workspace["ecs_service_back_desired_count"]
  container_port_front = local.workspace["container_port_front"]
  container_port_back = local.workspace["container_port_back"]
  ecs_task_mem_reservation_front = local.workspace["ecs_task_mem_reservation_front"]
  ecs_task_mem_reservation_back = local.workspace["ecs_task_mem_reservation_back"]
  awslogs_region = local.workspace["awslogs_region"]
  ecs_task_cpu_units_front = local.workspace["ecs_task_cpu_units_front"]
  ecs_task_cpu_units_back = local.workspace["ecs_task_cpu_units_back"]
  image_url_front = local.workspace["image_url_front"]
  image_url_back = local.workspace["image_url_back"]
  cw_retention_in_days_front = local.workspace["cw_retention_in_days_front"]
  cw_retention_in_days_back = local.workspace["cw_retention_in_days_back"]
}

# Variaveis do modulo Route53

module "route53" {
  source       = "./modules/route53"
  aws_route53_zone_id = local.workspace["aws_route53_zone_id"]
  aws_record_name = local.workspace["aws_record_name"]
  aws_alb_dns_name  = module.ec2.aws_alb_dns_name
  aws_alb_zone_id  = module.ec2.aws_alb_dns_zone_id
}