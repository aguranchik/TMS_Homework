provider "aws" {
  region                   = var.region
  shared_credentials_files = ["/Users/guranchik/.aws/credentials"]
  shared_config_files      = ["/Users/guranchik/.aws/config"]
  default_tags {
    tags = merge(var.common_tags)
  }
}