provider "aws" {
  region = "us-west-2"
}

module "vpc_module" {
  source              = "./modules/vpc_networking"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "vpc_module_2" {
  source              = "./modules/vpc_networking"
  vpc_cidr_block      = ""
  public_subnet_cidr  = ""
  private_subnet_cidr = ""
}
