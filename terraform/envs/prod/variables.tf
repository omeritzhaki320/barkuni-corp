variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
variable "availability_zones" { default = ["us-east-1a", "us-east-1b"] }
variable "vpc_name" { default = "barkuni-vpc" }
variable "allowed_cidrs" { default = ["0.0.0.0/0"] }
variable "cluster_name" { default = "barkuni-prod" }
variable "k8s_api_version" { default = "1.30" }
variable "instance_type" { default = "t3.medium" }