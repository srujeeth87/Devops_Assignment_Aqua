terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.28.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.24.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    one = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2023_x86_64_STANDARD"
      name= "node-1"
      instance_types = ["t3.medium"]
      #capacity_type = "ON_DEMAND"
      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "helm_release" "currency_converter" {
  name       = "currency-converter-v2"
  chart      = "../helm/currency-converter"
  namespace  = "default"

  set = [
    {
      name  = "image.repository"
      value = "srujeeth47/currency-converter"
    },
    {
      name  = "image.tag"
      value = "latest"
    }
  ]
}
