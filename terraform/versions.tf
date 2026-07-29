terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      version = "= 6.56.0"
      source  = "hashicorp/aws"
    }
  }
}
