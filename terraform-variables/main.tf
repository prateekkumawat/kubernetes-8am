resource "aws_vpc" "this" {
    cidr_block          =       var.vpc_cidr_block
    instance_tenancy    =       "default"
    tags    = {
        Name    = "tf-stage-vpc"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet1" {
    cidr_block      = var.subnet_cidr[0]  
    vpc_id          = aws_vpc.this.id
    availability_zone = var.subnet_az[0]
    tags    = {
        Name    = "tf-stage-subnet1-az1"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet2" {
    cidr_block      = var.subnet_cidr[1]
    vpc_id          = aws_vpc.this.id
    availability_zone = var.subnet_az[1]
    tags    = {
        Name    = "tf-stage-subnet2-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet3" {
    cidr_block      = var.subnet_cidr[2]
    vpc_id          = aws_vpc.this.id
    availability_zone = var.subnet_az[1]
    tags    = {
        Name    = "tf-stage-subnet3-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name    = "tf-stage-igw"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}