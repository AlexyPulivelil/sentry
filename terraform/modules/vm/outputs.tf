output "public_ip" {
  description = "VM public IP"
  value       = aws_instance.vm.public_ip
}

output "private_ip" {
  description = "VM private IP"
  value       = aws_instance.vm.private_ip
}
