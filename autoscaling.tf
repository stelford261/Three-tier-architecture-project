# Launch Template for Web Tier
resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-launch-template"
  image_id      = "ami-03df679d578135b9f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

# Auto Scaling Group for Web Tier
resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  min_size              = 1
  max_size              = 3
  desired_capacity      = 2
  vpc_zone_identifier   = [aws_subnet.public_web.id]

  tag {
    key                 = "Name"
    value               = "web_instance"
    propagate_at_launch = true
  }
}

# Launch Template for App Tier
resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-launch-template"
  image_id      = "ami-03df679d578135b9f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
}

# Auto Scaling Group for App Tier
resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  min_size              = 1
  max_size              = 3
  desired_capacity      = 2
  vpc_zone_identifier   = [aws_subnet.private_app.id]

  tag {
    key                 = "Name"
    value               = "app_instance"
    propagate_at_launch = true
  }
}
