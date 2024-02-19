# main.tf
module "infra" {
    source = "./setupInfra" 

    region = "us-east-1"

    prefix = "tf"
    repository_name = "backend"
    cluster_name = "cluster"
    image = "pedroquessada/my-backend:latest"

    role = "arn:aws:iam::211125361403:role/LabRole"
    profile = ""

    access_key = ""
    secret_key = ""
    session_token = ""
}

output "endpoint" {
  value = module.infra.lb_hostname
}

output "load_balancer_info" {
  value = module.infra.lb_info
}
