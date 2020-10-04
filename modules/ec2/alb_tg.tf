locals {
  alb_name = join("-", compact(list("alb", var.project, var.environment)))
  tg_front_name  = join("-", compact(list("tg-front", var.project, var.environment)))
  tg_back_name  = join("-", compact(list("tg-back", var.project, var.environment)))

  alb_tags = {
    Name         = upper(local.alb_name)
    Descritption = "Aplication Load Balancer ${upper(var.environment)}",
    Function     = "LOAD BALANCER"
  }

  alb_tg_front_tags = {
    Name         = upper(local.tg_front_name),
    Descritption = "Aplication Load Balancer Front Target Group ${upper(var.environment)}",
    Function     = "LOAD BALANCER TG"
  }

  alb_tg_back_tags = {
    Name         = upper(local.tg_back_name),
    Descritption = "Aplication Load Balancer Back Target Group ${upper(var.environment)}",
    Function     = "LOAD BALANCER TG"
  }
}

resource "aws_lb" "alb" {
  name                       = upper(local.alb_name)
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg_alb.id]
  subnets                    = [var.subnet_a_id, var.subnet_b_id]
  idle_timeout               = 180
  enable_deletion_protection = true

  tags = merge(var.default_tags, local.alb_tags)

}


resource "aws_alb_target_group" "tg_front" {
  name     = upper(local.tg_front_name)
  port     = "80"
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = merge(var.default_tags, local.alb_tg_front_tags)
}

resource "aws_alb_target_group" "tg_back" {
  name     = upper(local.tg_back_name)
  port     = "80"
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/api/produtos"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = merge(var.default_tags, local.alb_tg_back_tags)
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.tg_front]

  default_action {
    target_group_arn = aws_alb_target_group.tg_front.arn
    type             = "forward"
  }
}


resource "aws_alb_listener_rule" "alb-listener-rule" {
  listener_arn = aws_alb_listener.alb-listener.arn
  depends_on   = [aws_alb_listener.alb-listener]

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg_back.arn
  }

  condition {
    path_pattern {
      values = ["/api/produtos"]
    }
  }
}