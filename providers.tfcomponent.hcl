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

provider "aws" "main" {
  config {
    region = var.aws_region
    assume_role {
      role_arn = var.aws_role_arn
    }
  }
}

provider "random" "main" {}
