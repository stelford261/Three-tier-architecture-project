# EC2 Instances in App Tier
resource "aws_instance" "app_instance" {
  ami           = "ami-03df679d578135b9f" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_app.id
  security_groups = [aws_security_group.app_sg.id]
}