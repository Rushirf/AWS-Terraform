resource "aws_instance" "my-app" {
  ami = var.ami
  instance_type = var.instance_type
  user_data = var.user_data
  tags = var.ec2-tags
  security_groups = ["${var.security_grp_id}"]

}


output "ec2_id" {
  value = aws_instance.my-app.id
}


