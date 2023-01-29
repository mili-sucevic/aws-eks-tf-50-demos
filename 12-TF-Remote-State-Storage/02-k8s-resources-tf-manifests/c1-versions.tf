# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "ms-terraform-on-aws-eks"
    key    = "dev/app1-k8s/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "dev-app1-k8s"    
  }     
}