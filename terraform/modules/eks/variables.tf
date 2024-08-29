variable "cluster_name" {
  type        = string
  description = "EKS cluster Name"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the EKS cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS cluster"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS nodes"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of nodes in the node group"
}

variable "max_size" {
  type        = number
  description = "Maximum number of nodes in the node group"
}

variable "min_size" {
  type        = number
  description = "Minimum number of nodes in the node group"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the nodes"
}
