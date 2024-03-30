output "dns_name" {
  value = "http://${module.alb.dns}"
}