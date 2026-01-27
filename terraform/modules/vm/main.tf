# Latest Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# SSH key
resource "aws_key_pair" "vm_key" {
  key_name   = "vm-key"
  public_key = file(var.public_key_path)
}

# Security group
resource "aws_security_group" "vm_sg" {
  name = "vm-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ DIRECT aws_instance = 40 GiB GUARANTEED
resource "aws_instance" "vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.vm_key.key_name
  vpc_security_group_ids = [aws_security_group.vm_sg.id]

  root_block_device {
    volume_size           = var.root_volume_size  # 40 GiB ✅
    volume_type           = var.root_volume_type  # gp3 ✅
    delete_on_termination = true
  }

  tags = {
    Name = "app-vm"
  }
}
