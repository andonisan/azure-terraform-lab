provider "azurerm" {
  version = "2.15.0"
}

provider "random" {
  version = "~> 2.1"
}
resource "azurerm_resource_group" "lab" {
  name     = "lab-1-1"
  location = "northeurope"
}

resource "random_id" "lab" {
  keepers = {
    resource_group = "${azurerm_resource_group.lab.name}"
  }
  byte_length = 2
}
