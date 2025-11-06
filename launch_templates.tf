# create ec2 sg 

resource "aws_security_group" "ec2" {
 name =  "apache-ec2-sg"
 description = "apache-ec2-sg"
 vpc_id = aws_vpc.main.id

 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
   }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
} 

tags = {
    Name = "ec2_security_group"
}
  
}

# create launch template
resource "aws_launch_template" "apache_lt" {
  name = "apache_lt"
  image_id = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = filebase64("scripts/install_apache.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "apache-asg"
    }
  }
}
