resource "aws_vpc" "this" {
    cidr_block          =       "10.50.0.0/16"
    instance_tenancy    =       "default"
    tags    = {
        Name    = "tf-stage-vpc"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet1" {
    cidr_block      = "10.50.1.0/24" 
    vpc_id          = aws_vpc.this.id
    availability_zone = "ap-south-1a"
    tags    = {
        Name    = "tf-stage-subnet1-az1"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet2" {
    cidr_block      = "10.50.2.0/24" 
    vpc_id          = aws_vpc.this.id
    availability_zone = "ap-south-1b"
    tags    = {
        Name    = "tf-stage-subnet2-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet3" {
    cidr_block      = "10.50.3.0/24" 
    vpc_id          = aws_vpc.this.id
    availability_zone = "ap-south-1a"
    tags    = {
        Name    = "tf-stage-subnet3-az1"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    } 
}

resource "aws_subnet" "subnet4" {
    cidr_block      = "10.50.4.0/24" 
    vpc_id          = aws_vpc.this.id
    availability_zone = "ap-south-1b"
    tags    = {
        Name    = "tf-stage-subnet4-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
  
}