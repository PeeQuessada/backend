# main.tf
module "infra" {
    source = "./infra" 

    region = "us-east-1"

    prefix = "tf"
    repository_name = "backend"
    cluster_name = "cluster"
    image = "pedroquessada/my-backend:latest"

    role = "arn:aws:iam::211125361403:role/LabRole"
    profile = ""

    access_key = "ASIATCKANLL55ENKIL43"
    secret_key = "8s4vQk5qoe7mropytdw450myYUQWBS0avrM8R+kq"
    session_token = "FwoGZXIvYXdzEEEaDLrL2taGYcj6EMQZxCLQAf6iGsFHUtf5pCCsbulZaa+rOHwdhIRrbAO7livrnTfHyTJ0uEuKY0zH3Bn978csIgBHD2sFSeh+cJYP0SJQ0uE7UHYDL7GdSfjLfW7a4R75I3XRsycf5sSKx/pN3aw8LfrLWtToJl7eeBJGD8m3ZhQKFXr0npDGT2n8SCkHAiZU+J8PQUVq5351VeIgVouSgpJfHvSVMNtWLg6Dh2+IT4FSeHXYI5rUNkhbSF0WXCc3H2aUydtkDpcgAY2hB9SknssAvqtOQdNFa7x95zNQnv4or/DNrgYyLWy+AEp98+amb5VxakWokdV3RfllZmVxQc8r7Rws/GPmpy2KPgcZxerHzMdQ4Q=="
}

output "endpoint" {
  value = module.infra.lb_hostname
}

output "load_balancer_info" {
  value = module.infra.lb_info
}
