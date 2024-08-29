provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  name                = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones  = var.availability_zones
}

module "security_group" {
  source        = "../../modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  allowed_cidrs = var.allowed_cidrs
  tags = {
    Name = "eks-security-group"
  }
}

module "eks" {
  source            = "../../modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = var.k8s_api_version
  vpc_id            = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet_id, module.vpc.private_subnet_id]
  security_group_id = module.security_group.security_group_id

  cluster_role_arn = aws_iam_role.eks_cluster.arn
  node_role_arn    = aws_iam_role.eks_node.arn

  desired_capacity = 2
  max_size         = 3
  min_size         = 1
  instance_type    = var.instance_type
}
