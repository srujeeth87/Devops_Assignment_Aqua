variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "currency-converter-cluster"
}

variable "vpc_id" {
  description = "VPC ID where EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
