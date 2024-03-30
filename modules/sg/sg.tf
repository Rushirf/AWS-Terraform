resource "aws_security_group" "my-sg" {
  vpc_id = var.vpc_id
  tags = var.sg-tags
  lifecycle {
    ignore_changes = [ ingress ]
  }

  dynamic "ingress" {
    for_each = var.ingress
    content {
        protocol = ingress.value.ip_protocol
        from_port = ingress.value.port
        to_port = ingress.value.port
        cidr_blocks = ingress.value.cidr_blocks != "" ? [ingress.value.cidr_blocks] : null
        security_groups = ingress.value.cidr_blocks == "" ? [ingress.value.security_groups] : null
      
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}



output "sg-name" {
  value = aws_security_group.my-sg.name
}

output "sg-id" {
  value = aws_security_group.my-sg.id
}