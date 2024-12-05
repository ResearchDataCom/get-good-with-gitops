terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80"
    }
  }
}

provider "aws" {
  default_tags {
    tags = jsondecode(var.TAGS_ALL)
  }
}

data "aws_partition" "current" {}
