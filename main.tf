
provider "aws" {
    assume_role {
      role_arn = var.deployment_role
      session_name = "BucketExample"
      external_id = length(var.external_id) == 0 ? null : var.external_id
    }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "example_bucket" {
    bucket = "BucketExample-${data.aws_caller_identity.current.account_id}"
}