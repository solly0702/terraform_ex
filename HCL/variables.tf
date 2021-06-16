#Variables
# Can be specified on the command line with -var bucket_name=my-bucket
# or in files: terraform.tfvars or *.auto.tfvars
# or in environment variables: TF_VAR_bucket_name
variable "bucket_name" {
  # 'type' is an optional data type specification
  type    = string
  default = "my-bucket-14654123654"
  # 'default' is the optional default value. If 'default' is ommited
  # then a value must be supplied.
  #default ="my-bucket"
}

#Local Values
# Local values allow you to assign a name to an expression. Locals
# can make your code more readable.
locals {
  aws_account = "${data.aws_caller_identity.current.account_id}-${lower(data.aws_caller_identity.current.user_id)}"
  buckets = {
    bucket101 = "mybucket101"
    bucket102 = "mybucket102"
  }
}

# locals {
#   buckets = [
#     "mybucket101"
#     "mybucket102"
#   ]
# }

# Terraform supports simple and complex data types
locals {
  a_string  = "This is a string."
  a_number  = 3.1415
  a_boolean = true
  a_list = [
    "element1",
    2,
    "three"
  ]
  a_map = {
    key = "value"
  }

  # Complex
  person = {
    name = "Sol Lee",
    phone_numbers = {
      home   = "123-456-7890",
      mobile = "098-765-4321"
    },
    active = false,
    age    = 38
  }
}

#Operators
# Terraform supports arithmetic and logical operations in expressions too
locals {
  //Arithmetic
  three = 1 + 2 // addition
  two   = 3 - 1 // subtraction
  one   = 2 / 2 // division
  zero  = 1 * 0 // multiplication

  //Logical
  t = true || false // OR true if either value is true
  f = true && false // AND true if both values are true

  //Comparison
  gt  = 2 > 1  // true if right value is greater
  gte = 2 >= 1 // true if right value is greater or equal
  lt  = 1 < 2  // true if left value is greater
  lte = 1 <= 2 // true if left value is greater or equal
  eq  = 1 == 1 // true if left and right are equal
  neq = 1 != 2 // true if left and right are not equal
}

#Conditionals
variable "bucket_count" {
  type = number
}

locals {
  minimum_number_of_buckets = 5
  number_of_buckets         = var.bucket_count > 0 ? var.bucket_count : local.minimum_number_of_buckets
}
