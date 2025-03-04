
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