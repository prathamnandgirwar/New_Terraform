provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
  ami           = each.value
  instance_type = "t2.micro"
  for_each = toset(var.ami_ids)
}

variable "ami_ids" {
    default = [
        "ami-0c2b8ca1dad447f8",   # change ami values as per your region
        "ami-0c2b8ca1dad447f8",   #change ami values here
        "ami-0c2b8ca1dad447f8"
    ]
  
}