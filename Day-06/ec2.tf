provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "my-instance" {
    ami           = "ami-0c94855ba95c71c99"  # Amazon Linux 2 AMI
    instance_type = "t2.micro"

    tags = {
        Name = "MyEC2Instance"
    }
  
}

apply Now 
terraform init
terraform plan
terraform apply -auto-approve


For Remote state file storage

need backend 

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"  # Replace with your bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"  # Replace with your AWS region
    encrypt        = true
  }
}
