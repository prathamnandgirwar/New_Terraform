provider "aws" {
    region = "ap-south-1"
}

module "new_vpc" {
    source = "./modules/vpc"
}

module "instance" {
    source = "./modules/ec2"
    image_id = "ami-091138d0f0d41ff90"
    instance_type = "t3.micro"
    subnet_id = module.new_vpc.pub_subnet_id
    key_pair = "key-pair"
    vpc_id = module.new_vpc.vpc_id
}

