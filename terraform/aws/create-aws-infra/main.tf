# main.tf
module "infra" {
  source = "/"
}

output "infra" {
  value = module.infra
}
