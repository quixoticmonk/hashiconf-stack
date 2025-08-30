variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-2"
}

variable "aws_role_arn" {
  type        = string
  description = "AWS IAM role ARN to assume"
}

variable "identity_token" {
  type        = string
  description = "Web identity token for role assumption"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
  default     = ["us-west-2a", "us-west-2b"]
}
