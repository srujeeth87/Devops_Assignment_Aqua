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



