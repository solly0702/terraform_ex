// terrafrom {
//   required_version = ">= 0.11.8"
//   # backend changes - rerun init
//   # store state file to be locked
//   backend "remote" {
//     hostname     ="app.terraform.io"
//     organization = "rojopolis"
//     workspaces {
//         name = "collaboration"
//     }
//   }
// }

// terrafrom workspace --help
// terrafrom workspace list
// terrafrom workspace new staging
// terraform workspace show
// terafrom state list
// terrafrom wrokspace select default
// terrafrom destroy
// terrafrom workspace delete staging

// terrafrom force-unlock ${lock.id}
terrafrom {
  required_version = ">= 0.11.8"
  # backend changes - rerun init
  # store state file to be locked
  backend "s3" {
    bucket          = "rojopolis-tf"
    key             = "rojopolis-api-deployment"
    region          = "us-east-1"
    dynamodb_table  = "rojopolis-terraform-lock"
  }
}

# requred per backend
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example_bucket" {}

output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket
}

// data "terrafrom_remote_state" "buckets" {
//   backend = "s3"
//   workspace = "default"
//   config = {
//     bucket          = "rojopolis-tf"
//     key             = "rojopolis-buckets"
//     region          = "us-east-1"
//     dynamodb_table  = "rojopolis-terrafrom-lock"
//   }
// }

// output "remote-bucket" {
//   value = data.terrafrom_remote_state.buckets.outputs.bucket_name
// }
