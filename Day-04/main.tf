provider "aws" {
    region = "ap-south-1"
}

module "new_vpc" {
    source = "./modules/vpc"
}

module "instance" {
    source = "./modules/ec2"
    image_id = "ami-07a00cf47dbbc844c"
    instance_type = "t3.micro"
    subnet_id = module.new_vpc.pub_subnet_id
    vpc_id = module.new_vpc.vpc_id
}
