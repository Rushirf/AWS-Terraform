resource "aws_lb" "app-lb" {
  name = var.alb_name
  load_balancer_type = var.lb_type
  internal = var.internal
  security_groups = [ var.sg-id ]
  ip_address_type = var.ip_address_type
  subnets = var.subnets
}

resource "aws_lb_listener" "front-end" {
  load_balancer_arn = aws_lb.app-lb.arn
  port = var.port
  protocol = var.protocol
  default_action {
    target_group_arn = var.target_group_arn
    type = "forward"
  }

}

output "dns" {
  value = aws_lb.app-lb.dns_name
}