# resource "aws_instance" "this" {
#    count         = 3
#    instance_type = "t2.micro"
#    ami           = "ami-0f19324397f53458f"
#    tags = {
#      Name    = "ec2-${count.index + 1}"
#      created = "Terraform"
#      Team    = "Devops"
#      Costtag = "stage"
#    }
# }

# selection resources create or skip 
resource "aws_instance" "this" {
   count         = var.create_ec2_instance ? 1 : 0
   instance_type = "t2.micro"
   ami           = "ami-0f19324397f53458f"
   tags = {
     Name    = "ec2-${count.index + 1}"
     created = "Terraform"
     Team    = "Devops"
     Costtag = "stage"
   }
}

resource "aws_vpc" "this" {
  count               = var.vpc_create ? 1 : 0
  cidr_block          = "10.100.0.0/16"
  instance_tenancy    = "default"
    tags    = {
        Name    = "vpc-${count.index + 1}"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_instance" "this1" {
   count         = length(var.instances)
   instance_type = var.instances[count.index].instance_type
   ami           = var.instances[count.index].ami
}