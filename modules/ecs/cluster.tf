locals {
  cluster_name = join("-", compact(list( "ECS-Cluster", upper(var.project), upper(var.environment))))
}

resource "aws_ecs_cluster" "ecs_cluster"  {
    name = local.cluster_name
}