terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }

    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
