# Define Local Values in Terraform
locals {
  owners      = var.business_division
  environment = var.environment
  name        = "${var.business_division}-${var.environment}"

  # Group owners and environment into common_tags
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}