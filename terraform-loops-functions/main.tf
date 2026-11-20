# resource "aws_instance" "this" {
#    for_each     = var.instance_sets
#    instance_type = each.value
#    ami           = "ami-0f19324397f53458f"
#    tags = {
#      Name    = "ec2"
#      created = "Terraform"
#      Team    = "Devops"
#      Costtag = "stage"
#    }
# }



# resource "aws_instance" "this2" {
#    for_each     = { for inst in var.instance_map : inst.instnace_name => inst }
#    instance_type = each.value.instance_type
#    ami           = each.value.ami
#    tags = {
#      Name    = each.key
#      created = "Terraform"
#      Team    = "Devops"
#      Costtag = each.value.env
#    }
# }

# output "instance_ids" {
#   value = {
#     for k, v in aws_instance.this2 : k => {
#       id  = v.id 
#       public_ip = v.public_ip
#       private_ip = v.private_ip
#       name = v.tags["Name"]
#     }
#   }  
# }


data "aws_vpc" "vpc1" {
   id = var.vpc_id
}

data "aws_subnet" "subnet1"{
 id = var.subnet1_id 
}

data "aws_subnet" "subnet2"{
 id = var.subnet2_id 
}

resource "aws_subnet" "subnet3" {
 cidr_block = "10.0.16.0/20" 
 availability_zone = "ap-south-1b"
 vpc_id = data.aws_vpc.vpc1.id
 tags = {
  Name = "project-subnet-private2-ap-south-1b"
 }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-20261118*"]
  }

    owners = ["099720109477"]
}

resource "aws_instance" "this" {
    instance_type = "t2.micro"
    ami           = data.aws_ami.ubuntu.id
    subnet_id = data.aws_subnet.subnet1.id
    tags = {
      Name = "aws-subnet1"
    }
}

resource "aws_instance" "this2" {
    instance_type = "t2.micro"
    ami           = data.aws_ami.ubuntu.id
    subnet_id = data.aws_subnet.subnet2.id
    tags = {
      Name = "aws-subnet2"
    }
}