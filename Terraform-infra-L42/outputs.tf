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

output "gw_eip" {
  value = aws_eip.gw_eip.public_ip
}