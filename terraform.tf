terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  # Existing bucket. You must have an existing bucket for terraform to store state ile 
  backend "s3" {
    bucket       = "today14-2026"
    key          = "env/dev/terraform-Project-Resources.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
  }
}