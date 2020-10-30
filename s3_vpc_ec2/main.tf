# https://www.terraform.io/docs/providers/type/major-index.html
# https://github.com/shuaibiyy/awesome-terraform
# https://github.com/tfutils/tfenv
# https://github.com/cunymatthieu/tgenv
# https://github.com/gruntwork-io/terragrunt
# https://github.com/28mm/blast-radius
# https://registry.terraform.io

# terraform init
# terraform plan --var-file=production.tfvars
# terraform apply --ver-file=production.tfvars

module "vpc_networking" {
  source                  = "./vpc_networking"
  vpc_cidr_block          = var.vpc_cidr_block
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  public_subnet_3_cidr    = var.public_subnet_3_cidr
  private_subnet_1_cidr   = var.private_subnet_1_cidr
  private_subnet_2_cidr   = var.private_subnet_2_cidr
  private_subnet_3_cidr   = var.private_subnet_3_cidr
  eip_association_address = var.eip_association_address
  ec2_instance_type       = var.ec2_instance_type
  ec2_keypair             = var.ec2_keypair
}
