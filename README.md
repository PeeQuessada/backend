First Step
    Change Main.tf 
        replace the AccountId (211125361403) with your AccountId

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

    update kubectl
         aws eks --region {{us-east-1}} update-kubeconfig --name {{my-eks-cluster}}
    run deployment
        kubectl apply -f ./k8s/deployment.yaml 
    run service
        kubectl apply -f ./k8s/service.yaml   
    get service
        kubectl get svc   