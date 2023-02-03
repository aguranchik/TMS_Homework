module "network" {
  source      = "../network"
  az_required_number = var.az_required_number
  common_tags = { Environment = "${var.common_tags.Environment}" }
  cidr_block  = var.cidr_block
}