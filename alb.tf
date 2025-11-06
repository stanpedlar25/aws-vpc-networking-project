# created alb security group
resource "aws_security_group" "alb-sg" {
    name = "alb_security_group"
    description = "ALB security group"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
   }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
} 

tags = {
    Name = "alb_security_group"
}

}


# create alb
resource "aws_alb" "alb" {
    name = "apache-alb"
    security_groups = [aws_security_group.alb-sg.id]
    subnets = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
}

# Create target group
 resource "aws_alb_target_group" "tg" {
  name     = "apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}



 # create alb listener
  resource "aws_alb_listener" "http_listener" {
 load_balancer_arn = aws_alb.alb.arn
    port = "80"
    protocol = "HTTP" 
    
    default_action {
      target_group_arn = aws_alb_target_group.tg.arn
      type = "forward"

    }
    }