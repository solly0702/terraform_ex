// >terraform plan -var="bucket_name=my-s3-bucket"
variable "bucket_name" {
  # default = "my-s3-bucket"
  description = "Bucket name for S3"
}

resource "aws_s3_bucket" "variable_s3_bucket" {
  bucket = var.bucket_name == "" ? "default-s3-bucket" : "${var.bucket_name}-sol"
}

locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-423432fdsf"
  instance_type = local.instance_type

  tags {
    Name = local.instance_name
  }
}
