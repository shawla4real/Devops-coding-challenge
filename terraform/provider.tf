terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket       = "mytestbucketsola"
    key          = "tfstate/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}