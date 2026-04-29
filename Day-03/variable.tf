variable "image_id" {
    default = "ami-0e12ffc2dd465f6e4"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "vpc_security_group_ids" {
    default = ["sg-05b5716f7f2b3cf4e"]
}

variable "key_pair" {
    default = "key-pair"
}
variable "min_size" {
  default = 2
}
variable "max_size" {
  default = 5
}
variable "desired_capacity" {
  default = 3
}
variable "availability_zones" {
    default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
variable "vpc_id" {
  default = "vpc-0581ea11fada90f7e"
}
variable "subnets" {
    default = ["subnet-0ccf5cf373e20773a","subnet-046f68874024f7ed5","subnet-00c17503ddda43a7d"]
  
}