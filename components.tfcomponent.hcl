component "random_suffix" {
  source = "./modules/random-suffix"

  providers = {
    random = provider.random.source
  }

  inputs = {
    byte_length = 4
  }
}

component "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  providers = {
    aws = provider.aws.source
  }

  inputs = {
    name = "main-vpc"
    cidr = "10.0.0.0/16"

    azs             = ["us-west-2a", "us-west-2b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = false

    tags = {
      Environment = var.environment
    }
  }
}

component "s3_bucket_1" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  providers = {
    aws = provider.aws.source
  }

  inputs = {
    bucket = "my-app-data-bucket-${component.random_suffix.hex}"

    versioning = {
      enabled = true
    }

    server_side_encryption_configuration = {
      rule = {
        apply_server_side_encryption_by_default = {
          sse_algorithm = "AES256"
        }
      }
    }

    tags = {
      Name        = "App Data Bucket"
      Environment = var.environment
    }
  }
}

component "s3_bucket_2" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  providers = {
    aws = provider.aws.source
  }

  inputs = {
    bucket = "my-app-logs-bucket-${component.random_suffix.hex}"

    versioning = {
      enabled = true
    }

    server_side_encryption_configuration = {
      rule = {
        apply_server_side_encryption_by_default = {
          sse_algorithm = "AES256"
        }
      }
    }

    tags = {
      Name        = "App Logs Bucket"
      Environment = var.environment
    }
  }
}
