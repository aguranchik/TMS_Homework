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
  default = 3

}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "project_key" {
  type    = string
  default = "guranchik_project_key"
}

variable "key" {
  type    = string
  default = "guranchik-key-pair"
}

variable "common_tags" {
  type = map(string)
  default = {
    Owner       = "Guranchik"
    Environment = "dev"
    Project     = "Terraform-L43"
  }
}
