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

# Log app (Lambda function) activity in a CloudWatch log group.
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.STACK_NAME}"
  retention_in_days = 3
}

# Store players' scores in a DynamoDB table.
resource "aws_dynamodb_table" "this" {
  name         = "simple-scoreboard"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "name"

  attribute {
    name = "name"
    type = "S"
  }
}
