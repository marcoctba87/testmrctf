# Provider e armazenamento do tfstate no S3

provider "aws" {
  profile = "my-profile"
  region  = "us-east-1"
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    bucket  = "<bucket_name>"
    key     = "test-mrc/terraform.tfsate"
    region  = "us-east-1"
    profile = "my-profile"
  }
}
