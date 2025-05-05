# GCP Infrastructure as Code with Terraform

This repository contains Terraform scripts to deploy a Google Kubernetes Engine (GKE) cluster and its associated network infrastructure on Google Cloud Platform (GCP). It automates resource provisioning using Infrastructure as Code (IaC) principles.

## Features

- **GKE Cluster**: Deploys a Kubernetes cluster with configurable settings.
- **VPC Network**: Creates a Virtual Private Cloud (VPC) network and subnetwork.
- **Modular Design**: Leverages Terraform modules for reusability and organization.
- **GitHub Actions**: Automates Terraform deployment workflows.

## Prerequisites

1. **Google Cloud Project**: Ensure a GCP project with billing enabled.
2. **Service Account**: Create a service account with these roles:
    - `Kubernetes Engine Admin`
    - `Compute Network Admin`
    - `Service Account User`
3. **Terraform**: Install Terraform (v1.5.0 or later).
4. **GitHub Secrets**: Add these secrets to your repository:
    - `GCP_CREDENTIALS`: JSON key for the service account.
    - `GCP_PROJECT_ID`: Your GCP project ID.

## Usage

### 1. Clone the Repository

```sh
git clone https://github.com/your-repo/gcp-iaas-tf.git
cd gcp-iaas-tf
```

### 2. Configure Variables

Update `variables.tf` or create a `terraform.tfvars` file:

```hcl
project_id   = "your-gcp-project-id"
region       = "us-central1"
cluster_name = "my-gke-cluster"
node_count   = 3
machine_type = "e2-medium"
```

### 3. Initialize Terraform

```sh
terraform init
```

### 4. Plan and Apply

Preview changes:

```sh
terraform plan
```

Apply changes:

```sh
terraform apply -auto-approve
```

### 5. Access the GKE Cluster

Use the `cluster_endpoint` output to access the GKE cluster. Interact with the cluster using `kubectl`.

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow (`.github/workflows/terraform-deploy.yml`) to automate Terraform deployment. It performs the following steps:

1. Checks out the repository.
2. Sets up Terraform.
3. Authenticates with Google Cloud using the `GCP_CREDENTIALS` secret.
4. Initializes Terraform.
5. Dynamically creates a `terraform.tfvars` file from GitHub Secrets.
6. Runs `terraform plan` and `terraform apply`.

### Trigger the Workflow

Push changes to the `main` branch or manually trigger the workflow from the Actions tab.

Using GitHub Codespaces
GitHub Codespaces provides a cloud-based development environment where you can deploy the infrastructure without setting up Terraform locally.

Steps to Use Codespaces
Open the Repository in Codespaces:

Click the Code button in your repository and select Codespaces.
Create a new Codespace or open an existing one.
Authenticate with GCP:

Ensure the GCP_CREDENTIALS secret is added to your repository under Settings > Secrets and variables > Codespaces.
In the Codespace terminal, authenticate with GCP:

```echo $GCP_CREDENTIALS > gcp-key.json
gcloud auth activate-service-account --key-file=gcp-key.json
gcloud config set project $GCP_PROJECT_ID```

3. Run Terraform Commands:

Initialize Terraform:
```terraform init```
Plan and apply the infrastructure:
```terraform plan
terraform apply --auto-approve```

4. Clean Up:

Remove the gcp-key.json file after use:
```rm gcp-key.json
```
## Passing GCP Credentials from GitHub Secrets
To securely pass GCP credentials to your workflows or Codespaces:

1. Add Secrets to the Repository:

Go to Settings > Secrets and variables > Actions or Codespaces.
Add the following secrets:
GCP_CREDENTIALS: Paste the JSON key of your GCP service account.
GCP_PROJECT_ID: Add your GCP project ID.

2. Access Secrets in Workflows:

In GitHub Actions workflows, use the secrets as environment variables or inputs:
```
- name: Authenticate with Google Cloud
  uses: google-github-actions/auth@v1
  with:
    credentials_json: ${{ secrets.GCP_CREDENTIALS }}```

3. Access Secrets in Codespaces:

Secrets are automatically available as environment variables in Codespaces. Use them as shown in the Codespaces section above.

## Development Environment

A development container configuration (.devcontainer/devcontainer.json) is included for Visual Studio Code. It sets up a containerized environment with Terraform pre-installed.

Using Dev Containers
1. Install the Dev Containers extension in VS Code.
2. Open the repository in VS Code.
3. Reopen the folder in the dev container.

### Using Dev Containers

1. Install the Dev Containers extension in VS Code.
2. Open the repository in VS Code.
3. Reopen the folder in the dev container.

## License

This project is licensed under the Apache License 2.0.