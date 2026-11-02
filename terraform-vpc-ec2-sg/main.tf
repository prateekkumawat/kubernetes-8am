resource "aws_vpc" "this" {
    cidr_block          =       var.vpc_cidr_block
    instance_tenancy    =       "default"
    tags    = {
        Name    = "${var.projectname}-${var.env}-vpc"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet1" {
    cidr_block      = var.subnet_cidr[0]  
    vpc_id          = aws_vpc.this.id
    availability_zone = var.subnet_az[0]
    map_public_ip_on_launch = true
    tags    = {
        Name    = "${var.projectname}-${var.env}-subnet1-az1"
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
        Name    = "${var.projectname}-${var.env}-subnet2-az2"
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
        Name    = "${var.projectname}-${var.env}-subnet3-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_subnet" "subnet4" {
    cidr_block      = var.subnet_cidr[3]
    vpc_id          = aws_vpc.this.id
    availability_zone = var.subnet_az[0]
    map_public_ip_on_launch = true
    tags    = {
        Name    = "${var.projectname}-${var.env}-subnet4-az2"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name    = "${var.projectname}-${var.env}-igw"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.this.id
    }
    tags = {
        Name    = "${var.projectname}-${var.env}-public-rt"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

resource "aws_route_table_association" "subnet1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "subnet4" {
    subnet_id      = aws_subnet.subnet4.id
    route_table_id = aws_route_table.public.id
}


######### Security Group Creation #########

resource "aws_security_group" "this" {
    name        = "${var.projectname}-${var.env}-instance-sg"
    description = "Allow SSH and HTTP inbound traffic"
    vpc_id      = aws_vpc.this.id

    ingress {
        description = "SSH from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name    = "${var.projectname}-${var.env}-instnace-sg"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}

###### Instance SSH Key Creation #########

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "${var.projectname}-${var.env}-${var.key_name}"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "keys/${var.key_name}.pem"
  file_permission = "0600"
}

######## EC2 Instance Creation #########
resource "aws_instance" "this" {
    ami           = var.ami_id
    instance_type = var.instnace_type
    subnet_id     = aws_subnet.subnet1.id
    key_name      = aws_key_pair.this.key_name
    vpc_security_group_ids = [aws_security_group.this.id]
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                echo "<h1>Welcome to Terraform EC2 Instance< Manged By Terraform /h1>" | sudo tee /usr/share/nginx/html/index.html
            EOF
    tags = {
        Name    = "${var.projectname}-${var.env}-instance"
        created = "Terraform"
        Team    = "Devops"
        Costtag = "stage"
    }
}