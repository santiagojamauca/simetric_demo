########################################################
############ EKS cluster security group ################
########################################################

resource "aws_security_group" "elb_sg" {
  name        = "${var.environment}--cluster"
  description = "EKS ${var.environment} cluster security group"
  vpc_id      = var.vpc_id

  tags = {
        "Environment" = var.environment
        "Repo"        = "GenerativeAI/terraform"
        "Terraform"   = "Yes"
  }
}

resource "aws_security_group_rule" "elb_sg_ingress" {
  description              = "Node groups to cluster API"
  security_group_id        = aws_security_group.elb_sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.node.id
}

########################################################
######## EKS node shared security group ################
########################################################

resource "aws_security_group" "node" {
  name        = "${var.environment}-node"
  description = "EKS node shared security group"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all egress"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
        "Environment"                                       = var.environment
        "Repo"                                              = "GenerativeAI/terraform"
        "Terraform"                                         = "Yes"
        "kubernetes.io/cluster/${var.environment}" = "owned"
  }
}

resource "aws_security_group_rule" "node_ingress_cluster_api_4443_tcp_webhook" {
description              = "Cluster API to node 4443/TCP webhook"
security_group_id        = aws_security_group.node.id
type                     = "ingress"
from_port                = 4443
to_port                  = 4443 
protocol                 = "tcp"
source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_ingress_self_coredns_udp" {
  description       = "Node to node CoreDNS UDP"
  security_group_id = aws_security_group.node.id
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  self              = true
}

resource "aws_security_group_rule" "node_ingress_self_coredns_tcp" {
  description       = "Node to node CoreDNS TCP"
  security_group_id = aws_security_group.node.id
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group_rule" "node_ingress_cluster_api_kubelets" {
  description              = "Cluster API to node kubelets"
  security_group_id        = aws_security_group.node.id
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_ingress_cluster_api_9443_tcp_webhook" {
security_group_id        = aws_security_group.node.id
description              = "Cluster API to node 9443/tcp webhook"
type                     = "ingress"
from_port                = 9443
to_port                  = 9443
protocol                 = "tcp"
source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_ingress_cluster_api_8443_tcp_webhook" {
security_group_id        = aws_security_group.node.id
description              = "Cluster API to node 8443/tcp webhook"
type                     = "ingress"
from_port                = 8443
to_port                  = 8443
protocol                 = "tcp"
source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_ingress_cluster_api_6443_tcp_webhook" {
security_group_id        = aws_security_group.node.id
description              = "Cluster API to node 6443/tcp webhook"
type                     = "ingress"
from_port                = 6443
to_port                  = 6443
protocol                 = "tcp"
source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_ingress_cluster_groups" {
security_group_id        = aws_security_group.node.id
description              = "Cluster API to node groups"
type                     = "ingress"
from_port                = 443
to_port                  = 443   
protocol                 = "tcp"
source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "node_to_node_ingress_ephemeral_ports" {
security_group_id = aws_security_group.node.id
description       = "Node to node ingress on ephemeral ports"
type              = "ingress"
from_port         = 1025
to_port           = 65535 
protocol          = "tcp"
self              = true
}

########################################################
#### ENI attached to EKS Control Plane master nodes ####
########################################################
resource "aws_security_group" "eks_cluster_sg_" {
    name        = "eks-cluster-sg-${var.environment}"
    description = "EKS created security group applied to ENI that is attached to EKS Control Plane master nodes, as well as any managed workloads."
    vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all egress"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
        "Environment"                                       = var.environment
        "kubernetes.io/cluster/${var.environment}-" = "owned"
  }
}

resource "aws_security_group_rule" "eks-cluster-sg-_self" {
security_group_id = aws_security_group.eks_cluster_sg_.id
type              = "ingress"
from_port         = 0
to_port           = 0
protocol          = "-1"
self              = true
}

resource "aws_security_group_rule" "eks-cluster-sg-_cidr" {
security_group_id = aws_security_group.eks_cluster_sg_.id
cidr_blocks      = [var.cidr_block]
type              = "ingress"
from_port         = 0
to_port           = 0
protocol          = "-1"
}