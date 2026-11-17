variable "create_ec2_instance" {
  type        = bool
  default     = true
}

variable "vpc_create" {
  type        = bool
  default     = "true"
}

variable "instances" {
 type    = list(object({
   instance_type = string
   ami           = string
 }))
 default = [{
   ami           = "ami-0f19324397f53458f"
   instance_type = "t2.micro"
 },
 {
   ami           = "ami-0f19324397f53458f"
   instance_type = "t3.micro"
 },
 ]
}