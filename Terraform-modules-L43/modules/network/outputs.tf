output "az_count" {
  value = local.az_count
}

output "bits" {
  value = local.bits
}

output "subnet_cidr_bloks" {
  value = local.subnet_cidr_bloks
}

output "subnet_types" {
  value = local.subnet_types
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets
}

output "private_subnets" {
  value = aws_subnet.private_subnets
}

# output "gw_eip" {
#   value = aws_eip.gw_eip.public_ip
# }