# main.tf
module "infra" {
    source = "./infra" 
}

output "endpoint" {
  value = module.infra.lb_hostname
}

output "load_balancer_info" {
  value = module.infra.lb_info
}
