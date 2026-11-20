variable "create_vpc" {
  type        = bool
  default     = false
}

variable "vpc_cidr" {
  type = string 
  default = "10.100.0.0/16"
}

variable "env" {
  type = string
  default = "prod"

  validation {
    condition = contains(["prod", "dev", "qa"], var.env)
  
  error_message = "env values must be dev prod or qa"
  }
}

variable "instance_map_create" {
  type = bool 
  default = true
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
