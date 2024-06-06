# Create an additional IAM policy for Fargate #
resource "aws_iam_policy" "additional" {
  name_prefix = "eks-fargate-additional"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Role and Policy for SSO EKS user #
resource "aws_iam_role" "eks_sso_user_role" {
  name               = "eks-sso-user-role"
  assume_role_policy = data.aws_iam_policy_document.eks_sso_user_role_trust_policy.json
}

data "aws_iam_policy_document" "eks_sso_user_role_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account}:root"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_sso_user_role_policy_attachment" {
  role       = aws_iam_role.eks_sso_user_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}