resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      name = "my-vpc"
    } 
}

resource "aws_subnet" "pri_sub" {
    cidr_block = var.pri_sub_cidr
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      name = "pri-sub"
    }
}

resource "aws_subnet" "pub_sub" {
    cidr_block = var.pub_sub_cidr
    vpc_id = aws_vpc.my_vpc.id
    map_public_ip_on_launch = true
    tags = {
      name = "pub-sub"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      name = "my-igw"
    }
}