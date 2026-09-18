output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.cliff_eks.name
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = aws_eks_cluster.cliff_eks.endpoint
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.cliff_eks.arn
}

output "node_group_name" {
  description = "Name of the EKS managed node group"
  value       = aws_eks_node_group.cliff_nodes.node_group_name
}