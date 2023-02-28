# Resource: AWS IAM Group 
resource "aws_iam_group" "eks_developer_iam_group" {
  name = "${local.name}-eks-developer"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "eks_developer_iam_group_assumerole_policy" {
  name  = "${local.name}-eks-developer-group-policy"
  group = aws_iam_group.eks_developer_iam_group.name

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
        Sid    = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_developer_role.arn}"
      },
    ]
  })
}


# Resource: AWS IAM User 
resource "aws_iam_user" "eks_developer_user" {
  name = "${local.name}-eks-developer1"
  path = "/"
  force_destroy = true
  tags = local.common_tags
}


# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "eks_developer" {
  name = "${local.name}-eks-developer-group-membership"
  users = [
    aws_iam_user.eks_developer_user.name
  ]
  group = aws_iam_group.eks_developer_iam_group.name
}
