#Default route to Internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

#Routing table for private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, { Name = "private_rt" })
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

#Routing table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, { Name = "public_rt" })
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

#Associate  public subnet to public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnets[0].id
  route_table_id = aws_vpc.main.main_route_table_id
}

#Associate  private subnet to private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.private_rt.id
}