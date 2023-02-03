variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "az_required_number" {
  type    = number
  default = 2

}

variable "common_tags" {
  type = map(string)
  default = {
    Owner       = "Guranchik"
    Environment = "test"
    Project     = "Terraform-L43"
  }
}
