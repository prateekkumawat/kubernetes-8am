variable "region" {
  type = string 
  default = "ap-south-1"
}

variable "tags" {
  type = object({
     enviornment = string
     project     = string 
     ManageTeam  = string
     owned       = string 
     cost_allocation = string
  })
  default = { 
      enviornment  = "stage"
      project      = "myca"
      ManageTeam   = "devops"
      owned        = "client1"
      cost_allocation = "myca-client"
    }
}

variable "vpc_create" {
  type = bool
  default = false
}

variable "vpc_details" {
  type = list(object({
     name = string
     cidr_block = string 
     enable_dns_hostnames = bool
     enable_dns_support = bool 
     instance_tenancy = string
  }))
  default = [ 
    {
        name = "hsit-stage"
        cidr_block = "10.0.0.0/16"
        enable_dns_hostnames = true 
        enable_dns_support = true
        instance_tenancy = "default"
    }
   ]
}

variable "public_subnets_create" {
  type = bool
  default = false
}

variable "public_subnets_details" {
  type = list(object({
     name = string
     cidr_block = string 
     vpc_id = string
     map_public_ip_on_launch = bool
     availability_zone = string
  }))
  default = [ 
    {
        name = "hsit-stage-pub-az1-subnet1"
        vpc_id = "hsit-stage"
        cidr_block = "10.1.0.0/16"
        map_public_ip_on_launch = true
        availability_zone = "ap-south-1a"
    }
  ]
}

variable "private_subnets_create" {
  type = bool
  default = false
}

variable "private_subnets_details" {
  type = list(object({
     name = string
     cidr_block = string 
     vpc_id = string
     map_public_ip_on_launch = bool
     availability_zone = string
  }))
  default = [ 
    {
        name = "hsit-stage-priv-az1-subnet1"
        cidr_block = "10.11.0.0/16"
        vpc_id = "hsit-stage"
        map_public_ip_on_launch = false
        availability_zone = "ap-south-1a"
    }
   ]
}

variable "ds_subnets_create" {
  type = bool
  default = false
}

variable "ds_subnets_details" {
  type = list(object({
     name = string
     cidr_block = string 
     vpc_id = string
     map_public_ip_on_launch = bool
     availability_zone = string
  }))
  default = [ 
    {
        name = "hsit-stage-ds-az1-subnet1"
        cidr_block = "10.21.0.0/16"
        vpc_id = "hsit-stage"
        map_public_ip_on_launch = false
        availability_zone = "ap-south-1a"
    }
   ]
}

variable "internet_gateway_create" {
  type = bool 
  default = true
}

variable "internet_gateway_details" {
  type = list(string({
    name = string
    vpc_id = string
  }))
    default = [ 
        {
            name = "hsit-stage-igw"
            vpc_id = "hsit-stage"
        }
     ]
}

