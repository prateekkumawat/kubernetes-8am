variable "vpc_cidr_block" {
  type = string
  description = "please assign your vpc_cidr network"
  default = "10.50.0.0/16"
}

variable "subnet_cidr" {
  type = list
}

variable "subnet_az" {
  type = list
}

# variable "subnet_details" {
#   type = map(object({
#     cidr_block = string
#     availability_zone = string
#     vpc_id = string
#     map_public_ip_on_launch = optional(bool)
#   }))
# }