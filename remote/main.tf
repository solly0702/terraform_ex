# step1
# >terraform init
# >terraform plan
# >terraform apply
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_remote_state_bucket" {
  bucket = "tf-12-remote-states"
  region = "us-west-2"
}


# step2
# >terraform plan
# >terraform apply
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "tf-12-remote-states"
    key    = "aws_tf_remote_state_tfstates"
    region = "us-west-2"
  }
}

resource "aws_security_group" "security_group" {
  ingress {
    from_port   = 22
    protocal    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocal    = "TCP"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AWS_SG"
  }
}
