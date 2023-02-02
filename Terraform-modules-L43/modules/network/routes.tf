# #Default route to Internet
# resource "aws_route" "internet_access" {
#   route_table_id         = aws_vpc.main.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.gw.id
# }

#Routing table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.common_tags, { Name = "public_rt-${var.common_tags.Environment}" })
}

#Routing tables for private subnet
resource "aws_route_table" "private_rt" {
  count  = local.az_count
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }
  tags = merge(var.common_tags, { Name = "private_rt-${var.common_tags.Environment}-${count.index + 1}" })
}

#Associate  public subnet to public route table
resource "aws_route_table_association" "public_subnet_association" {
  count          = local.az_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

#Associate  private subnet to private route table
resource "aws_route_table_association" "private_subnet_association" {
  count          = local.az_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}