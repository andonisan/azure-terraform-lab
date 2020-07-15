provider "azurerm" {
  version = "2.15.0"
  features {

  }
}


resource "azurerm_resource_group" "lab" {
  name     = "lab-2-3"
  location = "westeurope"
}


