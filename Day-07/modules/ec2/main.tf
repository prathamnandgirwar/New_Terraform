resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.my_sg.id ]
    subnet_id = var.subnet_id
    key_name = var.key_pair  
}

resource "aws_security_group" "my_sg" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

        ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}