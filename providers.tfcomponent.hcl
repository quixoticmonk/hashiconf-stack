required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.1"
  }
}

provider "aws" "source" {
  config {
    #region = "us-east-1"
    assume_role_with_web_identity {
      role_arn           = var.aws_role_arn
      web_identity_token = var.identity_token
    }
  }
}

provider "random" "source" {}
