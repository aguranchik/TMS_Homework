resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, { Name = "gw" })
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.gw_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  depends_on    = [aws_internet_gateway.gw]
  tags          = merge(var.common_tags, { Name = "nat_gw" })
}