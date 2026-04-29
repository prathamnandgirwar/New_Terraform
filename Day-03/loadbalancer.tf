resource "aws_lb_target_group" "tg_home" {
    name = "tg-home"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
  
}

resource "aws_lb_target_group" "tg_cloth" {
    name = "tg-cloth"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
      path = "/cloth"
    }
  
}

resource "aws_lb" "app_lb" {
    name = "app-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ "sg-05b5716f7f2b3cf4e"]
    subnets = var.subnets
  
}

resource "aws_lb_listener" "app_lb_listener_home" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg_home.arn
    }
  
}


resource "aws_lb_listener_rule" "cloth_rule" {
  listener_arn = aws_lb_listener.app_lb_listener_home.arn
  priority     = 101

  condition {
    path_pattern {
      values = ["/cloth*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_cloth.arn
  }
}


resource "aws_autoscaling_attachment" "home_attach" {
    autoscaling_group_name = aws_autoscaling_group.asg-home.id
    lb_target_group_arn = aws_lb_target_group.tg_home.arn
}


resource "aws_autoscaling_attachment" "cloth_attach" {
    autoscaling_group_name = aws_autoscaling_group.asg-cloth.id
    lb_target_group_arn = aws_lb_target_group.tg_cloth.arn
}