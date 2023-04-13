#!/bin/bash

# Define the key pair name
key_pair_name="eks-tf-keypair"

# Define the key pair file path
file_path="/home/cloud_user/github/aws-eks-tf-50-demos/40-EKS-NLB-Basics/01-ekscluster-tf-manifests/private-key/$key_pair_name.pem"

if [ -f "$file_path" ]; then
  rm "$file_path"
fi

# Create the key pair
aws ec2 create-key-pair --key-name $key_pair_name --query 'KeyMaterial' --output text >> $file_path

# Change the permissions of the key file to secure it
chmod 400 $file_path

# Define the main folder that contains the top-level Terraform manifest
main_folder="/home/cloud_user/github/aws-eks-tf-50-demos/21-EKS-Admins-as-AWS-IAM-Users/"

# Define the subfolders containing Terraform manifests
subfolder_1="/home/cloud_user/github/aws-eks-tf-50-demos/21-EKS-Admins-as-AWS-IAM-Users/01-ekscluster-tf-manifests/"
# subfolder_2="/home/cloud_user/github/aws-eks-tf-50-demos/15-EBS-K8S-SampleApp-YAML/02-ebs-tf-manifests"
# subfolder_3=$4

# Go to main folder
cd $main_folder

# Initialize the main folder
terraform init

# Format the main folder
terraform fmt -recursive 

# Validate the main folder
terraform validate

# Apply the changes in the main folder
# terraform apply -auto-approve -lock=false

# Wait until the changes are completed
terraform apply --wait=60s

# # Go to eks_cluster folder
cd $subfolder_1

# # Repeat the process for eks_cluster 1
terraform fmt -recursive
terraform validate 
terraform init
terraform apply -auto-approve
terraform apply --wait=900s

# # Go to subfolder_2
# cd $subfolder_2

# # Repeat the process for subfolder 2
# terraform fmt -recursive
# terraform validate
# terraform init
# terraform apply -auto-approve
# terraform apply --wait=60s

# # Repeat the process for subfolder 3
# terraform fmt -recursive $subfolder_3
# terraform validate $subfolder_3
# terraform init $subfolder_3
# terraform apply -auto-approve $subfolder_3
# terraform apply --wait=60s $subfolder_3
