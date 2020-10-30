provider "aws" {
  region  = "us-west-2"
  version = "~> 2.0"
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-54321wfds"
  instance_type = "t2.micro"
  key_name      = data.aws_instance.ec2_data.key_name

  tags {
    Name = "sol-ec2-instance"
  }
}

data "aws_instance" "ec2_data" {
  instance_id = "54542gffdg"
}

data "aws_vpc" "default_vpc" {
  cidr_block = "10.0.0.0/16"
}
