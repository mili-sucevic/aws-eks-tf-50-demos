#!/bin/bash

# Define the AWS region
region="us-east-1"

# Define the key pair name
key_pair_name="eks-tf-keypair"

# Define the key pair file path
file_path="[FILE_PATH_TO_SUBFOLDER_1]/$key_pair_name.pem"

# Remove the existing key, if there isn't one create new
if [ -f "$file_path" ]; then
  rm "$file_path"
fi

# Create the key pair
aws ec2 create-key-pair --region $region --key-name $key_pair_name --query 'KeyMaterial' --output text >> $file_path

# Change the permissions of the key file to secure it
chmod 400 $file_path

# Define the main folder that contains the top-level Terraform manifest
main_folder="[FILE_PATH_TO_MAIN_FOLDER]"

# Define the subfolders containing Terraform manifests
subfolder_1="[FILE_PATH_TO_SUBFOLDER_1]"
subfolder_2="[FILE_PATH_TO_SUBFOLDER_2]"
# subfolder_3=$4

# Go to main folder
cd $main_folder

# Format the main folder
terraform fmt -recursive 

# Validate the main folder
terraform validate

# Initialize the main folder
terraform init

# Apply the changes in the main folder
terraform apply -auto-approve

# Wait until the changes are completed
terraform apply --wait=60s

# Go to main folder
cd $subfolder_1

# Repeat the process for subfolder 1
terraform fmt -recursive
terraform validate 
terraform init
terraform apply -auto-approve
terraform apply --wait=900s

# Go to main folder
cd $subfolder_2

# Repeat the process for subfolder 2
terraform fmt -recursive
terraform validate
terraform init
terraform apply -auto-approve
terraform apply --wait=60s

# # Repeat the process for subfolder 3
# terraform fmt -recursive $subfolder_3
# terraform validate $subfolder_3
# terraform init $subfolder_3
# terraform apply -auto-approve $subfolder_3
# terraform apply --wait=60s $subfolder_3