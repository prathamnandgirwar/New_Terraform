provider "aws" {
  region = "ap-south-1"
}

resource "aws_launch_template" "launch-template-home" {
    name = "launch-template-home"
    image_id = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.vpc_security_group_ids
    key_name = var.key_pair
    user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "Welcome to home page" > /var/www/html/index.nginx-debian.html
    EOF
    )
  
}



resource "aws_launch_template" "launch-template-cloth" {
    name = "launch-template-cloth"
    image_id = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.vpc_security_group_ids
    key_name = var.key_pair
    user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo mkdir -p /var/www/html/cloth
    echo "sale sale sale" > /var/www/html/cloth/index.html
    EOF
    )
  
}


resource "aws_autoscaling_group" "asg-home" {
    name = "asg-home"
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    availability_zones = var.availability_zones

    launch_template {
      id = aws_launch_template.launch-template-home.id
      version = "$Latest"
    }
  
}

resource "aws_autoscaling_policy" "asp-home" {
    name = "asp-home"
    autoscaling_group_name = aws_autoscaling_group.asg-home.name
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }
  
}


resource "aws_autoscaling_group" "asg-cloth" {
    name = "asg-cloth"
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    availability_zones = var.availability_zones

    launch_template {
      id = aws_launch_template.launch-template-cloth.id
      version = "$Latest"
    }
  
}

resource "aws_autoscaling_policy" "asp-cloth" {
    name = "asp-cloth"
    autoscaling_group_name = aws_autoscaling_group.asg-cloth.name
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }
  
}