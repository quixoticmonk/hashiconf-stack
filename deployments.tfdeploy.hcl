deployment "dev" {
  inputs = {
    aws_region   = "us-east-1"
    aws_role_arn = "arn:aws:iam::697621333100:role/may-webinar-role"
    environment  = "dev"
    vpc_cidr     = "10.0.0.0/16"
    identity_token= identity_token.aws.jwt
  }
}

