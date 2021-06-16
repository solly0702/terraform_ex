# Also used in more advanced use cases: modules, remote_state
# Outputs can be retrieved at any time by running 'terraform output'
# terraform output bucket_info
output "bucket_info" {
  value = aws_s3_bucket.bucket1
}

output "aws_caller_info" {
  value = data.aws_caller_identity.current
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "bucketX" {
  value = aws_s3_bucket.bucketX
}

output "bucketE" {
  value = aws_s3_bucket.bucketE
}

output "home_phone" {
  value = local.person.phone_numbers.home
}

output "logical" {
  value = "${local.t} ${local.f}"
}

output "comparison" {
  value = "${local.gt} ${local.gte} ${local.lt} ${local.lte} ${local.eq} ${local.neq}"
}

#Functions
# Terraform has 100+ built in functions (but no ability to define custom functions!
# https://www.terraform.io/docs/configuration/functions.html
# The syntax for a function call is <function_name>(<arg1>, <arg2>).

locals {
  //Date and Time
  ts            = timestamp() //Returns the current date and time.
  current_month = formatdate("MMMM", local.ts)
  tomorrow      = formatdate("DD", timeadd(local.ts, "24h"))
}

output "date_time" {
  value = "${local.current_month} ${local.tomorrow}"
}

locals {
  //Numeric
  number_of_buckets_2 = max(local.minimum_number_of_buckets, var.bucket_count)
}

locals {
  //String
  lcase          = lower("A mixed case String")
  ucase          = upper("a lower case string")
  trimmed        = trimspace(" A string with leading adn trailing spaces   ")
  formatted      = format("Hello %s", "World")
  formatted_list = formatlist("Hello %s", ["John", "Paul", "George", "Ringo"])
}

output "string_functions" {
  value = local.formatted_list
}

#Iteration
# HCL has a 'for' syntax for iterrating over list values.
locals {
  l          = ["one", "two", "three"]
  upper_list = [for item in local.l : upper(item)]
  upper_map  = { for item in local.l : item => upper(item) }
}

output "iterrations" {
  value = local.upper_list
}

#Filtering
# The 'for' syntax can also take an 'if' clause.
locals {
  n     = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  evens = [for i in local.n : i if i % 2 == 0]
}

output "filtered" {
  value = local.evens
}

#Heredocs
# HCL supports more complex string templating that can be used to generate
# full descriptive paragraphs too.
output "heredoc" {
  value = <<-EOT
    This is called 'heredoc'. Ti's a string literal
    that can span multiple lines.
  EOT
}

output "directive" {
  value = <<-EOT
    This is a 'heredoc' with directives.
    %{if local.person.name == ""}
    Sorry, I don't know your name.
    %{else}
    Hi ${local.person.name}
    %{endif}
  EOT
}

output "iterated" {
  value = <<-EOT
    Directives can also iterate...
    %{for number in local.evens}
    ${number} is even.
    %{endfor}
  EOT
}
