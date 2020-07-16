provider "azurerm" {
  version = "2.15.0"
  features {

  }
}

module "networking-a" {
  source   = "./modules/Networking"
  prefix   = "${var.prefix}a"
  location = var.location
}

module "networking-b" {
  source   = "./modules/Networking"
  prefix   = "${var.prefix}b"
  location = var.location
}

module "myawesomelinuxvm-a" {
  source   = "./modules/my_linux_vm"
  prefix   = "${var.prefix}a"
  location = var.location
  username = var.username
  vm_size  = "Standard_A2_v2"

}

module "myawesomelinuxvm-b" {
  source   = "./modules/my_linux_vm"
  prefix   = "${var.prefix}b"
  location = var.location
  username = var.username
  vm_size  = "Standard_A2_v2"
}
