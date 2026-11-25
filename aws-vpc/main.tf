resource "aws_vpc" "this" {
    for_each                =    var.vpc_create ? { for k in var.vpc_details : k.name => k } : {}

    cidr_block              =    each.value.cidr_block
    instance_tenancy        =    each.value.instance_tenancy
    enable_dns_hostnames    =    each.value.enable_dns_hostnames
    enable_dns_support      =    each.value.enable_dns_support
    tags                    =    merge({ "Name" = each.key }, var.tags)   
}

resource "aws_subnet" "public_subnet" {
    for_each                =    var.public_subnets_create ? { for k in var.public_subnets_details : k.name => k } : {}
    
    cidr_block              =    each.value.cidr_block
    vpc_id                  =    aws_vpc.this[each.value.vpc_id].id
    availability_zone       =    each.value.availability_zone
    map_public_ip_on_launch =    each.value.map_public_ip_on_launch
    tags                    =    merge({ "Name" = each.key }, var.tags) 
}


resource "aws_subnet" "private_subnet" {
    for_each                =    var.private_subnets_create ? { for k in var.private_subnets_details : k.name => k } : {}
    
    cidr_block              =    each.value.cidr_block
    vpc_id                  =    aws_vpc.this[each.value.vpc_id].id
    availability_zone       =    each.value.availability_zone
    map_public_ip_on_launch =    each.value.map_public_ip_on_launch
    tags                    =    merge({ "Name" = each.key }, var.tags) 
}

resource "aws_subnet" "ds_subnet" {
    for_each                =    var.ds_subnets_create ? { for k in var.ds_subnets_details : k.name => k } : {}
    
    cidr_block              =    each.value.cidr_block
    vpc_id                  =    aws_vpc.this[each.value.vpc_id].id
    availability_zone       =    each.value.availability_zone
    map_public_ip_on_launch =    each.value.map_public_ip_on_launch
    tags                    =    merge({ "Name" = each.key }, var.tags) 
}


resource "aws_internet_gateway" "this" {
    for_each                =     var.internet_gateway_create ? { for k in var.internet_gateway_details : k.name => k } : {}
    
    vpc_id                  =     aws_vpc.this[each.value.vpc_id].id
    tags                    =     merge({ "Name" = each.key }, var.tags)

}