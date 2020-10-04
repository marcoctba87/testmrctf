# Criação de apontamento DNS para o endereço do ALB

resource "aws_route53_record" "cname_route53_record" {
  depends_on    = [var.aws_alb_dns_name]
  zone_id = var.aws_route53_zone_id
  name    = var.aws_record_name
  type    = "A"
  alias {
    name = var.aws_alb_dns_name
    zone_id = var.aws_alb_zone_id
    evaluate_target_health = false
  }
}