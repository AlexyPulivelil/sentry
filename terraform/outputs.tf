output "public_ip" {
  value = module.vm.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${module.vm.public_ip}"
}