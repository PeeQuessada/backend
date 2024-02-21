# Descrição do projeto

<details>
<summary>*Read this in [English](README.md)*</summary>
</details>

Este repositório contém os artefatos necessários para executar e gerenciar a aplicação usando Docker, GitHub Actions e Terraform. Siga as instruções abaixo para configurar e executar o ambiente corretamente.

## Estrutura do Repositório

- **app**: Contém a aplicação e os arquivos Docker necessários para sua execução.
- **.github/workflows**: Contém os pipelines da esteira (CI/CD) utilizando GitHub Actions.
- **terraform**: Contém os scripts Terraform para provisionar a infraestrutura na AWS.

### GitHub Actions

<details>
<summary>Pipeline Manual (create-aws-infra)</summary>

O pipeline `create-aws-infra` é destinado à criação manual da infraestrutura. Ele provisiona os recursos necessários na AWS para executar a aplicação. Execute manualmente este pipeline quando desejar criar o ambiente pela primeira vez.

</details>

<details>
<summary>Pipeline Automático (deploy-k8s)</summary>

O pipeline `deploy-k8s` é acionado automaticamente quando há um merge na branch main. Ele executa as etapas necessárias para implantar a aplicação no Elastic Kubernetes Service (EKS).

</details>

### Configuração de Variáveis Secretas

Para que os pipelines funcionem corretamente, é necessário configurar as seguintes variáveis secretas no GitHub:

- `user_id`: ID do usuário.
- `user_key`: Chave do usuário.
- `secret_key`: Chave secreta.
- `token`: Token de acesso.

### Configuração de Variáveis de Ambiente

Configure as seguintes variáveis de ambiente:

- `region`: Região da AWS.
- `prefix`: Prefixo para recursos.
- `repository_name`: Nome do repositório.
- `cluster`: Nome do cluster Kubernetes.

### Configuração do GitHub Actions

1. Acesse a página do seu repositório no GitHub.
2. Clique em "Settings" e depois em "Secrets".
3. Adicione as variáveis secretas mencionadas acima.

### Execução do Terraform

1. Certifique-se de ter o Terraform instalado localmente.
2. Navegue até a pasta `terraform/create-aws-infra` e execute o comando `terraform init && terraform apply`.
3. Execute o comando `aws eks --region ${{ secrets.REGION }} update-kubeconfig --name ${{ secrets.PREFIX }}-${{ secrets.REPOSITORY_NAME }}-${{ secrets.CLUSTER_NAME }}` para vincular o cluster Kubernetes.

4. Se necessário, repita o processo para a pasta `terraform/deploy-k8s`.

Isso deve criar a infraestrutura necessária na AWS e implantar a aplicação no EKS. Certifique-se de entender as configurações específicas nos arquivos Terraform antes de executar.

---

<details>
<summary>*Read this in English*</summary>

</details>
