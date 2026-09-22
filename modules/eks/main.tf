# =========================
# EKS WORKER NODE LAUNCH TEMPLATE
# =========================

resource "aws_launch_template" "eks_worker" {
  name_prefix = "eks-worker-"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.node_group_name
    }
  }
}


# =========================
# EKS CLUSTER
# =========================

resource "aws_eks_cluster" "cliff_eks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  # Match the existing imported EKS cluster
  bootstrap_self_managed_addons = false

  # =========================
  # CLOUDWATCH LOGGING
  # =========================

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}


# =========================
# EKS MANAGED NODE GROUP
# =========================

resource "aws_eks_node_group" "cliff_nodes" {
  cluster_name    = aws_eks_cluster.cliff_eks.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

  subnet_ids     = var.private_subnet_ids
  instance_types = var.node_instance_types

  launch_template {
    id      = aws_launch_template.eks_worker.id
    version = aws_launch_template.eks_worker.latest_version
  }

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_eks_cluster.cliff_eks
  ]
}