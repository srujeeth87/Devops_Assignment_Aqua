# 💱 Currency Converter Microservice – DevOps Assignment

## 📌 Objective

This project is a DevOps assignment to demonstrate end-to-end design and deployment of a currency conversion microservice using Python, Docker, Kubernetes, Helm, Terraform, Jenkins, and GitHub Actions.

---

## 🚧 Design Decisions

- **Language:** Python + FastAPI for quick prototyping and auto-generated documentation.
- **UI:** Embedded within FastAPI using Jinja2 templates (no separate frontend).
- **Exchange API:** [exchangerate.host](https://exchangerate.host) with API key support.
- **Containerization:** Docker with minimal `python:3.9-slim` base image.
- **Deployment:** Helm chart used to deploy the app to an EKS (AWS) Kubernetes cluster.
- **Infrastructure:** Terraform provisions AWS EKS, IAM roles, and Helm deployment.
- **CI/CD:** GitHub Actions used for automated build & push. Jenkins used for Docker build/test.

---

## 🏁 How to Run Locally (Docker)

```bash
# Step 1: Clone the repo
git clone https://github.com/<your-username>/Devops_Assignment_Aqua.git
cd Devops_Assignment_Aqua

# Step 2: Build and run
docker build -t currency-converter .
docker run -d -p 8000:8000 --name converter currency-converter

# Step 3: Open in browser
http://localhost:8000
```

🚢 How to Deploy Using Helm

Ensure your kubectl context points to your Kubernetes cluster.

```bash
cd helm/currency-converter/

# Update values.yaml or use CLI overrides
helm install currency-converter . --values values.yaml
```

How to Provision Infra Using Terraform (AWS)

🔧 Prerequisites
AWS CLI configured (aws configure)
Terraform >= 1.3 installed

```BASH
cd terraform/

# Initialize Terraform
terraform init

# Review planned changes
terraform plan -var-file="terraform.tfvars"

# Apply the infrastructure
terraform apply -var-file="terraform.tfvars"
```

CI/CD Pipeline – GitHub Actions

Path: .github/workflows/pipeline.yml
Runs on push to main or PR. Steps include:

Build Docker image
Push to Docker Hub
(Bonus) Helm Lint
Manual Trigger
```bash
on:
  push:
    branches: [ "main" ]
  workflow_dispatch:
```
  
To trigger:
-- Commit and push code to main

-------

CI/CD Pipeline – Jenkins

Jenkinsfile provided in root
Uses dockerUtils.groovy from vars/ in shared lib
Steps:
- Clone GitHub repo
- Build Docker image
- Push to Docker Hub
- Run health check
- Cleanup in post stage

Ensure Jenkins agent:
  - Has Docker installed
 - Uses valid Docker Hub credentials via withCredentials

--------

Secrets and Configuration

- API_KEY for exchangerate.host should be passed via environment variable in the code.
- Docker Hub credentials managed via Jenkins credentials store.









