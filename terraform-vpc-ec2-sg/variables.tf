variable "vpc_cidr_block" {
  type = string
  description = "please assign your vpc_cidr network"
  default = "10.50.0.0/16"
}

variable "env" {
}

variable "projectname" {
}

variable "subnet_cidr" {
  type = list
}

variable "subnet_az" {
  type = list
}

variable "instnace_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {}
variable "ami_id" {}
