///////////////////////////////
///// AWS Provider

provider "aws" {
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.aws_region}"
}

///////////////////////////////
///// Create Statefile Buckets

resource "aws_s3_bucket" "terraform-statefile-bucket" {
  bucket = "${var.tag_customer}-statefiles"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

///////////////////////////////
///// Create DynamoDB Tables

resource "aws_dynamodb_table" "dynamodb-statefile-lock" {
  name           = "${var.tag_customer}-statefile-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}