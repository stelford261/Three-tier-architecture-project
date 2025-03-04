
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