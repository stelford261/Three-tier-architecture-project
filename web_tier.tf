# EC2 Instances in Web Tier
resource "aws_instance" "web_instance" {
  ami           = "ami-03df679d578135b9f" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_web.id
  security_groups = [aws_security_group.web_sg.id]
}

