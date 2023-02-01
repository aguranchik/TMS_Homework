# resource "aws_eip" "gw_eip" {
#   vpc  = true
#   tags = merge(var.common_tags, { Name = "gw_eip" })
# }

resource "aws_eip" "nat_gw_eip" {
  count = local.az_count
  vpc   = true
  tags  = merge(var.common_tags, { Name = "nat_gw_eip-${count.index + 1}" })
}
