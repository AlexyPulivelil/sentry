variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "instance_type" {
  type    = string
  default = "t3.xlarge"
}

variable "subnet_id" {
  type = string
}

variable "allowed_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "public_key_path" {
  type = string
}

variable "root_volume_size" {
  type    = number
  default = 40
}

variable "root_volume_type" {
  type    = string
  default = "gp3"
}
