
provider "aws" {
    region = var.region
    assume_role {
      role_arn = var.deployment_role
      session_name = "BucketExample"
      external_id = length(var.external_id) == 0 ? null : var.external_id
    }
}

data "aws_caller_identity" "current" {
    count = var.deploy_resources == true ? 1 : 0
}

resource "aws_s3_bucket" "example_bucket" {
    count = var.deploy_resources == true ? 1 : 0
    bucket = "BucketExample-${data.aws_caller_identity.current[count.index].account_id}"
}