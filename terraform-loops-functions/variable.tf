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

variable "instance_sets" {
  type        = set(string)
  default     = ["t2.micro", "t3.micro"]
}

variable "instance_map" {
  type        = list(object({
    instance_type = string
    ami = string
    env = string
    instnace_name = string
  }))
  default = [
  {
    instance_type = "t2.micro"
    ami = "ami-0f19324397f53458f"
    env = "stage"
    instnace_name = "hsit-stage-ins"
  },
  {
    instance_type = "t3.micro"
    ami = "ami-0f19324397f53458f"
    env = "prod"
    instnace_name = "hsit-prod-ins"
  }
  ]
}


variable "vpc_id" {
  default = "vpc-0d9737cda3a9bfe33"
}

variable "subnet1_id" {
  default = "subnet-02a53ccb3553830e8"
}
variable "subnet2_id" {
  default = "subnet-0abd81bd82e402b80"
}