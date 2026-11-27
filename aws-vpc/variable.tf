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
  default = true
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
  default = true
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
  default = true
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
  type = list(object({
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

variable "nat_eip_enable" {
  type = bool 
  default = true
}

variable "nat_eip_details" {
  type = list(object({
     name = string
  }))
  default = [ 
    {
      name = "hsit-stage-nat-eip"
    }
   ]
}

variable "nat_gateway_enable" {
  type = bool 
  default = true
}

variable "nat_gateway_details" {
  type = list(object({
     name = string
     subnet_id = string
     eip_allocation_id = string
  }))
  default = [ 
    {
      name = "hsit-stage-nat-gateway"
      subnet_id = "hsit-stage-pub-az1-subnet1"
      eip_allocation_id = "hsit-stage-nat-eip"
    }
   ]
}

variable "route_tables" {
  type = list(object({
    name           = string
    vpc_id         = string
    cidr_block     = optional(string, "0.0.0.0/0")
    gateway_id     = optional(string, null)
    nat_gateway_id = optional(string, null)
  }))

  default = [
    {
      name       = "hsit-stage-public"
      vpc_id     = "hsit-stage"
      gateway_id = "hsit-stage-igw"
    },
    {
      name           = "hsit-stage-private"
      vpc_id         = "hsit-stage"
      nat_gateway_id = "hsit-stage-nat-gateway"
    }
  ]
}

variable "subnet_assosiate" {
  type = list(object({
    route_table_name = string
    subnet_id        = list(string)
  }))
  default = [{
    route_table_name = "hsit-stage-public"
    subnet_id        = ["hsit-stage-pub-az1-subnet1"]
    },
    {
      route_table_name = "hsit-stage-private"
      subnet_id        = ["hsit-stage-priv-az1-subnet1"]
    },
  ]
}

