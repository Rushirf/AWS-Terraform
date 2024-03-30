resource "aws_lb_target_group" "my-tg" {
  name = var.tg_name
  port = var.tg_port
  protocol = var.tg_protocol
  vpc_id = var.vpc_id
}


resource "aws_lb_target_group_attachment" "tg-attchment" {
  for_each = var.instance_ids
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id = each.value
}


output "tg_arn" {
  value = aws_lb_target_group.my-tg.arn
}