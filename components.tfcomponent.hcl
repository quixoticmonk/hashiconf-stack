component "random_suffix" {
  source = "./modules/random"

  providers = {
    random = provider.random.main
  }
}

component "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  providers = {
    aws = provider.aws.main
  }

  inputs = {
    name = "main-vpc"
    cidr = var.vpc_cidr

    azs             = var.availability_zones
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = false

    tags = {
      Environment = var.environment
    }
  }
}

component "s3_bucket_data" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  providers = {
    aws = provider.aws.main
  }

  inputs = {
    bucket = "my-app-data-bucket-${component.random_suffix.bucket_suffix}"

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

component "s3_bucket_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  providers = {
    aws = provider.aws.main
  }

  inputs = {
    bucket = "my-app-logs-bucket-${component.random_suffix.bucket_suffix}"

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
