module "ec2" {
  source          = "../modules/ec2"
  for_each        = var.ec2
  ec2-tags        = each.value.ec2-tags
  ami             = each.value.ami
  instance_type   = each.value.instance_type
  security_grp_id = module.sg["ec2-sg"].sg-name
  user_data       = each.value.user_data
}


module "tg" {
  depends_on   = [ module.ec2 ]
  source       = "../modules/tg"
  vpc_id       = var.tg["vpc_id"]
  tg_name      = var.tg["tg_name"]
  tg_port      = var.tg["tg_port"]
  tg_protocol  = var.tg["tg_protocol"]
  instance_ids = {for i,j in module.ec2: i=>j.ec2_id}
}


module "sg" {
  source   = "../modules/sg"
  for_each = var.sg
  sg-tags  = each.value.sg-tags
  vpc_id   = each.value.vpc_id
  ingress  = each.value.ingress
}

module "alb" {
  source           = "../modules/alb"
  alb_name         = var.alb["alb_name"]
  lb_type          = var.alb["lb_type"]
  internal         = var.alb["internal"]
  ip_address_type  = var.alb["ip_address_type"]
  subnets          = var.alb["subnets"]
  sg-id            = module.sg["lb-sg"].sg-id
  target_group_arn = module.tg.tg_arn
  port             = var.alb["port"]
  protocol         = var.alb["protocol"]
}


