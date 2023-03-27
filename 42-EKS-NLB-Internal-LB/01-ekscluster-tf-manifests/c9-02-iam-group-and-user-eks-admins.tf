# AWS IAM Group 
resource "aws_iam_group" "eks_admins_iam_group" {
  name = "${local.name}-eks-admins"
  path = "/"
}

# AWS IAM Group Policy
resource "aws_iam_group_policy" "eks_admins_iam_group_assumerole_policy" {
  name  = "${local.name}-eks-admins-group-policy"
  group = aws_iam_group.eks_admins_iam_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_admin_role.arn}"
      },
    ]
  })
}


# AWS IAM User - Basic User 
resource "aws_iam_user" "eks_admin_user" {
  name          = "${local.name}-eks-admin-03"
  path          = "/"
  force_destroy = true
  tags          = local.common_tags
}

# AWS IAM Group Membership
resource "aws_iam_group_membership" "eks_admins" {
  name = "${local.name}-eks-admins-group-membership"
  users = [
    aws_iam_user.eks_admin_user.name
  ]
  group = aws_iam_group.eks_admins_iam_group.name
}