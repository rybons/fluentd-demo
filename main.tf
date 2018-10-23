////////////////////////////////////////////
///// AWS Provider

provider "aws" {
  version                 = "1.23.0"
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
}

////////////////////////////
///// Configure Backend

terraform {
  required_version = "0.11.7"

  backend "s3" {
    encrypt        = true
    bucket         = "test-customer-statefiles"
    dynamodb_table = "test-customer-statefile-lock"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    profile        = "devops-indellient"
  }
}

////////////////////////////////////////////
///// Elastic, Logstash and Kibana

# This instance is meant to receive and process logs
module "collector" {
    source = "git@github.com:rybons/fluentd-collector.git"
}

////////////////////////////////////////////
///// Application with fluentd agent

# This instance is meant to report logs to the collector

module "reporter" {
    source = "git@github.com:rybons/fluentd-reporter.git"
}