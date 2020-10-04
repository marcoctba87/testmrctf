# Declaração de variáveis locais

locals {
  sg_alb_name = join("-", compact(list("sg", "alb", var.project, var.environment)))

  sg_alb_tags = {
    Name        = upper(local.sg_alb_name),
    Function    = "SECURITY GROUP"
  }
}


# Cria security group para liberação de tráfego no ALB

resource "aws_security_group" "sg_alb" {
  name        = upper(local.sg_alb_name)
  description = "SG para o ALB ambiente ${upper(var.environment)}"
  vpc_id      = var.vpc_id

# Libera o tráfego de entrada HTTP/HTTPS

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.sg_alb_cidr_blocks
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sg_alb_cidr_blocks
  }

# Libera o tráfego de saída

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, local.sg_alb_tags)
}