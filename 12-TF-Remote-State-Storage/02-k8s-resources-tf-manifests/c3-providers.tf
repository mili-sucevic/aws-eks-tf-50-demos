# Terraform AWS Provider Block
# "aws" provider block is used to configure the AWS provider
# Responsible for communicating with the AWS API to create, update, and delete resources
# The provider block typically includes configuration options such as the "access_key" and "secret_key" for authentication, as well as a "region"
provider "aws" {
  region = "us-east-1"
}

# The name argument is set to data.terraform_remote_state.eks.outputs.cluster_id, which references the cluster ID of the EKS cluster stored in a remote state file. 
# The first block retrieve the cluster information and the second block retrieve the authentication information.
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}