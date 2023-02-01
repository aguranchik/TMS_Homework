resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, { Name = "gw" })
}

resource "aws_nat_gateway" "nat_gw" {
  count         = local.az_count
  allocation_id = aws_eip.nat_gw_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  depends_on    = [aws_internet_gateway.gw]
  tags          = merge(var.common_tags, { Name = "nat_gw-${count.index + 1}" })
}