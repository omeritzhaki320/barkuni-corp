variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of allowed CIDR blocks for security group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
