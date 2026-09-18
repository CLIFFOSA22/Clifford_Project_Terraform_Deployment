# =========================
# EKS CLUSTER ROLE NAME
# =========================

variable "eks_cluster_role_name" {
  type        = string
  default     = "cliff-eks-cluster-role"
  description = "Name of the IAM role for the EKS cluster"
}


# =========================
# EKS NODE ROLE NAME
# =========================

variable "eks_node_role_name" {
  type        = string
  default     = "cliff-eks-node-role"
  description = "Name of the IAM role for the EKS worker nodes"
}