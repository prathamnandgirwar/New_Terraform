provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami = "ami-0c2b8ca1dad447f8"
    instance_type = "t2.micro"
    count = 3
}
