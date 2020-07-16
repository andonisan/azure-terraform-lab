variable "prefix" {}
variable "location" {}
variable "username" {}
variable "vm_size" {}
variable "rg_name" {}


data 


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!"
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-my-vm"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}myvm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    # ssh_keys {
    #   path     = "/home/${var.username}/.ssh/authorized_keys"
    #   key_data = tls_private_key.main.public_key_openssh
    # }
  }

  os_profile {
    computer_name  = "${var.prefix}myvm"
    admin_username = var.username
    admin_password = random_password.password.result
  }
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-my-pubip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}

output "vm-password" {
  value       = random_password.password.result
  description = "Dynamically generated password to access the VM."
}
output "private-ip" {
  value       = azurerm_network_interface.main.private_ip_address
  description = "Private IP Address"
}

output "public-ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "Public IP Address"
}
