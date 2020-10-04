output "subnet_sg_id" {
  value = aws_security_group.sg_alb.id
}

output "tg_group_arn_front" {
  value = aws_alb_target_group.tg_front.arn
}

output "tg_group_arn_back" {
  value = aws_alb_target_group.tg_back.arn
}

output "aws_alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "aws_alb_dns_zone_id" {
  value = aws_lb.alb.zone_id
}