#vpc creation
resource "aws_vpc" "TT-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TT-vpc"
  }
}

# subnets creation
resource "aws_subnet" "public_web" {
  vpc_id     = aws_vpc.TT-vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public_web"
  }
}

#private subnet (app-tier)
resource "aws_subnet" "private_app" {
  vpc_id     = aws_vpc.TT-vpc.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private_app"
  }
}

#private subnet (db-tier)
resource "aws_subnet" "private_db" {
  vpc_id     = aws_vpc.TT-vpc.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "eu-west-2c"

  tags = {
    Name = "private_db"
  }
}



