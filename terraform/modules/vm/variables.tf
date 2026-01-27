variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "allowed_cidr" {
  type = string
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