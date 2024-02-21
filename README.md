# Project Description

<details>
<summary>Leia isto em [Português (Brasileiro)](README_ptbr.md)</summary>
</details>

This repository contains the necessary artifacts to run and manage the application using Docker, GitHub Actions, and Terraform. Follow the instructions below to set up and run the environment properly.

## Repository Structure

- **app**: Contains the application and the Docker files required for its execution.
- **.github/workflows**: Contains the GitHub Actions pipelines for CI/CD.
- **terraform**: Contains Terraform scripts to provision infrastructure on AWS.

### GitHub Actions

<details>
<summary>Manual Pipeline (create-aws-infra)</summary>

The `create-aws-infra` pipeline is intended for manual infrastructure creation. It provisions the necessary resources on AWS to run the application. Manually execute this pipeline when you want to create the environment for the first time.

</details>

<details>
<summary>Automated Pipeline (deploy-k8s)</summary>

The `deploy-k8s` pipeline is triggered automatically upon a merge into the main branch. It executes the necessary steps to deploy the application on Elastic Kubernetes Service (EKS).

</details>

### Configuration of Secret Variables

To ensure the pipelines function correctly, configure the following secret variables on GitHub:

- `user_id`: User ID.
- `user_key`: User key.
- `secret_key`: Secret key.
- `token`: Access token.

### Configuration of Environment Variables

Configure the following environment variables:

- `region`: AWS region.
- `prefix`: Resource prefix.
- `repository_name`: Repository name.
- `cluster`: Kubernetes cluster name.

### GitHub Actions Setup

1. Go to your repository page on GitHub.
2. Click on "Settings" and then "Secrets".
3. Add the secret variables as mentioned above.

### Terraform Execution

1. Ensure that Terraform is installed locally.
2. Navigate to the `terraform/create-aws-infra` folder and execute the command `terraform init && terraform apply`.
3. Run the command `aws eks --region ${{ secrets.REGION }} update-kubeconfig --name ${{ secrets.PREFIX }}-${{ secrets.REPOSITORY_NAME }}-${{ secrets.CLUSTER_NAME }}` to link the Kubernetes cluster.

4. If necessary, repeat the process for the `terraform/deploy-k8s` folder.

This should create the necessary infrastructure on AWS and deploy the application on EKS. Ensure you understand the specific configurations in the Terraform files before executing them.

---