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

#route table creation
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.TT-vpc.id

  route = []

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.TT-vpc.id

  route = []

  tags = {
    Name = "private-route-table"
  }
}

#route table association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_web.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_app.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private_db.id
  route_table_id = aws_route_table.private-route-table.id
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.TT-vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# NAT Gateway for Private Subnet
resource "aws_eip" "nat-eip" {
  tags = {
    Name = "TT-eip"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public_web.id
}

resource "aws_route" "private_to_nat" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_app.id
  route_table_id = aws_route_table.private-route-table.id
}