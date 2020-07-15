provider "azurerm" {
  version = "2.15.0"
  features{

  }
}

resource "azurerm_resource_group" "lab" {
  name     = "lab-3-0"
  location = "northeurope"
}

module "workshop"{
   source = "./function"
   resource_group_name = azurerm_resource_group.lab.name
   resource_group_location = azurerm_resource_group.lab.name

}