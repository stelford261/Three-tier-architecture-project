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