module "instance_dev" {
  source        = "./modules/instances"
  region        = "us-east-1"
  az_required_number=1
  instance_type = "t2.micro"
  cidr_block    = "10.10.0.0/16"
  common_tags   = { Environment = "dev" }
}

module "instance_prod" {
  source        = "./modules/instances"
  region        = "us-east-1"
  az_required_number=2
  instance_type = "t2.micro"
  cidr_block    = "10.0.0.0/16"
  common_tags   = { Environment = "prod" }
}