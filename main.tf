# =========================
# VPC MODULE
# =========================

module "vpc" {
  source = "./modules/vpc"
}


# =========================
# EC2 MODULE
# =========================

module "ec2" {
  source = "./modules/ec2"

  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.vpc.ec2_security_group_id
  target_group_arn  = module.vpc.target_group_arn
}


# =========================
# IAM MODULE
# =========================

module "iam" {
  source = "./modules/iam"
}


# =========================
# ECR MODULE
# =========================

module "ecr" {
  source = "./modules/ecr"
}

# =========================
# EKS MODULE
# =========================

module "eks" {
  source = "./modules/eks"

  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn

  depends_on = [
    module.iam
  ]
}

# =========================
# KMS MODULE
# =========================

module "kms" {
  source = "./modules/kms"
}