resource "aws_lb" "p2_alb" {
  name               = "p2-alb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.p2_alb_sg.id]
  subnets            = [aws_subnet.p2_public_subnet.id,aws_subnet.p2_public_subnet_2.id]

 enable_cross_zone_load_balancing = true

  tags = {
    Name = "p2_alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.p2_alb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.p2_ec2_target.arn
  }
}

resource "aws_lb_target_group" "p2_ec2_target" {
  name     = "ec2-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.p2_vpc.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.p2_ec2_target.arn
  target_id        = aws_instance.p2_ec2.id
  port             = 80
}


output "alb_dns_name" {
  value = aws_lb.p2_alb.dns_name
}
