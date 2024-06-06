module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.environment}"
  cluster_version = "1.30"

  cluster_security_group_id = aws_security_group.elb_sg.id

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  cluster_addons = {
    vpc-cni = {
      most_recent = true
    }
  kube-proxy = {
      most_recent = true
    }

  coredns = {
      most_recent = true
      resolve_conflicts = "OVERWRITE"
      configuration_values = jsonencode({
      "computeType" : "fargate"
      })
    }

  vpc_id = var.vpc_id
  subnet_ids = [
    aws_subnet.eks_private_1.id,
    aws_subnet.eks_private_2.id,
    aws_subnet.eks_private_3.id,
    aws_subnet.eks_private_4.id
  ]

  # Configure Fargate profiles
  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        },
        {
          namespace = "kube-system"
        }
      ]
    },

    platform = {
      name = "platform"
      selectors = [
        {
          namespace = "platform"
        }
      ]
    }
  }

  # Configure Fargate profile defaults
  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
    subnet_ids = [
      aws_subnet.eks_private_1.id,
      aws_subnet.eks_private_2.id,
      aws_subnet.eks_private_3.id,
      aws_subnet.eks_private_4.id
    ]
    tags = {
      "k8s-app" = "kube-dns"
    }
  }
}