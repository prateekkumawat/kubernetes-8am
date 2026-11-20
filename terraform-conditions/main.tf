resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.vpc_cidr
  enable_dns_hostnames =  true 
  enable_dns_support = true 

  tags = {
    Name = "hsit-vpc-terraform"
  }
}

resource "aws_instance" "this1" {
  count = var.env == "prod" ? 1 : 0

  ami = "ami-0f19324397f53458f"
  instance_type = "t2.micro"
  tags = {
    Name = "hsit-prod-ins"
  }
}

resource "aws_instance" "this2" {
  count = var.env == "qa" ? 1 : 0

  ami = "ami-0f19324397f53458f"
  instance_type = "t2.large"

  tags = {
    Name = "hsit-tst-ins"
  }
}

resource "aws_instance" "this3" {
  count = var.env == "dev" ? 1 : 0

  ami = "ami-0f19324397f53458f"
  instance_type = "t3.micro"

  tags = {
    Name = "hsit-stage-ins"
  }
}


resource "aws_instance" "this4" {
   for_each     =  var.instance_map_create ? { for inst in var.instance_map : inst.instnace_name => inst } : {}
   instance_type = each.value.instance_type
   ami           = each.value.ami
   tags = {
     Name    = each.key
     created = "Terraform"
     Team    = "Devops"
     Costtag = each.value.env
   }
}