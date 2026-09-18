# =========================
# VPC OUTPUTS
# =========================

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}


# =========================
# ALB OUTPUT
# =========================

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.vpc.alb_dns_name
}


# =========================
# EC2 OUTPUTS
# =========================

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}