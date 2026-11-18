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

resource "aws_instance" "this2" {
   for_each     = { for inst in var.instance_map : inst.instnace_name => inst }
   instance_type = each.value.instance_type
   ami           = each.value.ami
   tags = {
     Name    = each.key
     created = "Terraform"
     Team    = "Devops"
     Costtag = each.value.env
   }
}

output "instance_ids" {
  value = {
    for k, v in aws_instance.this2 : k => {
      id  = v.id 
      public_ip = v.public_ip
      private_ip = v.private_ip
      name = v.tags["Name"]
    }
  }  
}