output "linux-private-ip" {
  value       = azurerm_network_interface.linux.private_ip_address
  description = "Linux Private IP Address"
}

output "linux-public-ip" {
  value       = azurerm_public_ip.linux.ip_address
  description = "Linux Public IP Address"
}