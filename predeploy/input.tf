////////////////////////////
///// AWS Provider Inputs

variable "aws_region" {
  description = "The region to deploy resources to"
  default = "us-east-1"
}

variable "aws_profile" {
  type = "string"
  description = "The name of the profile in ~/.aws/credentials that determines where the resources are deployed (e.g. mykeyname)"
}

////////////////////////////
///// Tags

variable "tag_customer" {
  type = "string"
  description = "The customer the environment is for."
  default = "test-customer"
}
