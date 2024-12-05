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

# Grant the Lambda function read-only access to players' scores.
data "aws_iam_policy_document" "lambda_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.${data.aws_partition.current.dns_suffix}"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = var.STACK_NAME
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["${aws_cloudwatch_log_group.this.arn}:log-stream:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:BatchGetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:ConditionCheckItem",
    ]
    resources = [aws_dynamodb_table.this.arn]
  }
}

resource "aws_iam_policy" "this" {
  name   = var.STACK_NAME
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

# Deploy the Lambda function.
resource "aws_lambda_function" "this" {
  function_name    = var.STACK_NAME
  role             = aws_iam_role.this.arn
  filename         = "lambda-function.zip"
  source_code_hash = filebase64sha256("lambda-function.zip")
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  architectures    = ["x86_64"]

  logging_config {
    log_group  = aws_cloudwatch_log_group.this.name
    log_format = "Text"
  }
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}
