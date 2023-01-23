# Terraform Remote State Datasource
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../../08-AWS-EKS-Cluster/terraform-manifests/terraform.tfstate"
  }
}

# AWS S3 Bucket to store tfstate in a remote location
# We will use the Terraform State file terraform.tfstate file from ekscluster Terraform project to get the EKS Resources information