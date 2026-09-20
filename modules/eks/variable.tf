variable "cluster_name" {
  type        = string
  default     = "cliff-eks-cluster"
  description = "Name of the EKS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EKS"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS cluster"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS worker nodes"
}

variable "node_instance_types" {
  type        = list(string)
  default     = ["t3.small"]
  description = "EC2 instance types for the EKS worker nodes"
}