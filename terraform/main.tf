module "vm" {
  source = "./modules/vm"

  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  allowed_cidr    = var.allowed_cidr
  public_key_path = var.public_key_path
  
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
}
