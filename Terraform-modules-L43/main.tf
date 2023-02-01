module "network" {
  source      = "./modules/network"
  region      = "us-east-1"
  cidr_block  = "10.10.0.0/16"
  common_tags = { Environment = var.common_tags.Environment }
}
