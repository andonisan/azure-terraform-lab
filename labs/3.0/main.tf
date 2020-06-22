provider "azurerm" {
  version = "2.15.0"
}

resource "azurerm_resource_group" "lab" {
  name     = "lab-3-0"
  location = "northeurope"
}