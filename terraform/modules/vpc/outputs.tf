variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "name" {
  type        = string
  description = "Name tag for the VPC and subnets"
}
