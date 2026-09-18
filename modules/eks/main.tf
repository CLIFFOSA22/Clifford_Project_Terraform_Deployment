# =========================
# EKS CLUSTER
# =========================

resource "aws_eks_cluster" "cliff_eks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}


# =========================
# EKS MANAGED NODE GROUP
# =========================

resource "aws_eks_node_group" "cliff_nodes" {
  cluster_name    = aws_eks_cluster.cliff_eks.name
  node_group_name = "cliff-node-group"
  node_role_arn   = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  instance_types = var.node_instance_types

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_eks_cluster.cliff_eks
  ]
}