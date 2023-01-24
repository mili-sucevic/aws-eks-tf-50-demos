# Terraform Local State Datasource
# data "terraform_remote_state" "eks" {
#   backend = "local"
#   config = {
#     path = "../../08-AWS-EKS-Cluster/terraform-manifests/terraform.tfstate"
#   }
# }

# We will use the Terraform State file terraform.tfstate file from ekscluster Terraform project to get the EKS Resources information
# Terraform Remote State Datasource
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "msq-terraform-on-aws-eks"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1" 
  }
}
