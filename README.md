First Step
    Change Main.tf FIle to replace the AccountId (211125361403) with your AccountId


HCL - HashiCorp Configuration Language

    initialize
        terraform init
    plan
        terraform plan
    execute
        terraform apply
    finish 
        terraform destroy

RUN Kubernets
    aws eks --region {{us-east-1}} update-kubeconfig --name {{my-eks-cluster}}
    kubectl apply -f ./k8s/deployment.yaml 
    kubectl apply -f ./k8s/service.yaml 