output "PublicIP" {
  value = aws_instance.this.public_ip
}

output "PrivateIP" {
  value = aws_instance.this.private_ip
}

output "public_dns" {
  value = aws_instance.this.public_dns
}

output "private_dns" {
  value = aws_instance.this.private_dns
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_security_groups" {
  value = aws_instance.this.vpc_security_group_ids
}