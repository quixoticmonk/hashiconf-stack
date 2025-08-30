variable "aws_role_arn" {
  type        = string
  description = "AWS IAM role ARN to assume"
}

variable "identity_token" {
  type        = string
  ephemeral   = true
  description = "Identity token for AWS authentication"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
  default     = "dev"
}
