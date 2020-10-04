# Declaração de variáveis locais

locals {
  subnet_name_a = join("-", compact(list("subnet_A", var.project, var.environment)))
  subnet_tags_a = {
    Name        = upper(local.subnet_name_a)
    Description = "Subnet A do ambiente ${upper(var.environment)}"
  }
  subnet_name_b = join("-", compact(list("subnet_B", var.project, var.environment)))
  subnet_tags_b = {
    Name        = upper(local.subnet_name_b)
    Description = "Subnet B do ambiente ${upper(var.environment)}"
  }
}


# Cria 2 subnets para utilização com o Application Load Balancer

resource "aws_subnet" "subnet_a" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_a

  tags = merge(var.default_tags, local.subnet_tags_a)
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_b

  tags = merge(var.default_tags, local.subnet_tags_b)
}
