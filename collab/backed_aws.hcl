terraform {
    required_version = ">= 0.11.8"
    backend "s3" {
        bucket          = "rojopolis-tf"
        key             = "rojopolis-api-deployment"
        region          = "us-east-1"
        dynamodb_table  = "rojopolis-terraform-lock"
    }
}