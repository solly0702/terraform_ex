# terraform init
# terraform plan -out example.tfplan
# terraform apply example.tfplan
# terraform destroy
# terraform state list

#Terraform
# Optional configuration for the Terraform Engine
terraform {
  required_version = ">=0.12.0"
}

#Provider
# Implement cloud specific API and Terraform API.
# Provider configuration is specific to each provider.
# Providers expose Data Sources and Resources to Terraform.
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"

  #Many providers also accept configuration via environment variables
  #or config files. The AWS provider will read the standard AWS CLI
  #settings if they are present.
}

#Resources
# Objects mananged by Terraform such as VMs or S3 Buckets
# Declaring a Resource tells Terraform that it shoud CREATE
# and manage the Resource described. If the Resource already exists
# it must be imported into Terrafrom's state.
resource "aws_s3_bucket" "bucket1" {
  # auto generated as "terrafrom-*"
  bucket = ""
}

# Interpolation
# Substitute values in strings.
resource "aws_s3_bucket" "bucket2" {
  bucket = "${data.aws_caller_identity.current.account_id}-bucket2"
}

#Dependency
# Resources can depend on one another. Terraform will ensure that all
# dependencies are met before creating the resource. Dependency can
# be implict or explicit.
# terrafrom graph > graph.dot
resource "aws_s3_bucket" "bucket3" {
  bucket = "${data.aws_caller_identity.current.account_id}-bucket3"
  tags = {
    # Implicit demendency (bucket2 were created before creating bucket3)
    dependency = aws_s3_bucket.bucket2.arn
  }
}

resource "aws_s3_bucket" "bucket4" {
  bucket = "${data.aws_caller_identity.current.account_id}-bucket4"
  depends_on = [
    aws_s3_bucket.bucket3
  ]
}

resource "aws_s3_bucket" "bucket5" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket" "bucket6" {
  bucket = "${local.aws_account}-bucket6"
}

#Count
# All resources have a 'count' parameter. The default is 1.
# if count is set then a list of resources is returned (even if there is only 1)
# If 'count' is set then a 'count.index' value is available. This value contains
# the current iteration number.
# TIP: setting 'count = 0' is a handy way to remove a resource but keep the config.
resource "aws_s3_bucket" "bucketX" {
  count  = 5
  bucket = "${local.aws_account}-bucket${count.index + 7}"
}

#for_each
# Resources may have a 'for_each' parameter.
# If for_each is set then a resource is created for each item in the set and a
# special 'each' object is available. The 'each' object has 'key' and 'value'
# attributes that can be referenced.
resource "aws_s3_bucket" "bucketE" {
  # for_each = toset(local.buckets)
  # bucket   = "${local.aws_account}-${each.key}"
  for_each = local.buckets
  bucket   = "${local.aws_account}-${each.value}"
}

resource "aws_s3_bucket" "buckets" {
  count  = local.number_of_buckets
  bucket = "${local.aws_account}-bucket${count.index + 7}"
}

#Data Sources
# Objects NOT managed by Terraform.

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}
