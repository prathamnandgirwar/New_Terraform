provider "aws" {
    region = "ap-south-1"
}

module "new_vpc" {
    source = "./modules/vpc"
}

module "instance" {
    source = "./modules/ec2"
    image_id = var.image_id
    instance_type = var.instance_type
    subnet_id = module.new_vpc.pub_subnet_id
    vpc_id = module.new_vpc.vpc_id
}

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"  # Replace with your bucket name
    key            = "terraform.tfstate"
    region         = "ap-south-1"  # Replace with your AWS region
    
  }
}









# terraform apply -var-file="dev.tfvars"