locals {
  az_count     = length(data.aws_availability_zones.available.names) >= var.az_required_number ? var.az_required_number : length(data.aws_availability_zones.available.names)
  subnet_types = ["private", "public"]
  bits         = ceil(log(local.az_count * length(local.subnet_types), 2))

  subnet_cidr_bloks = {
    for i, name in local.subnet_types :
    "${name}" => [
      for subnet_num in range(i * local.az_count, (i + 1) * local.az_count) :
      cidrsubnet(var.cidr_block, local.bits, subnet_num)
    ]
  }
}

resource "aws_subnet" "public_subnets" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.subnet_cidr_bloks.public[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  depends_on        = [aws_vpc.main]
  tags              = merge(var.common_tags, { Name = "Public Subnet ${count.index + 1}" })
}

resource "aws_subnet" "private_subnets" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.subnet_cidr_bloks.private[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  depends_on        = [aws_vpc.main]
  tags              = merge(var.common_tags, { Name = "Private Subnet ${count.index + 1}" })
}
