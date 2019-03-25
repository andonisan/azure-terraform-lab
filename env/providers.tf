provider "azurerm" {
  version         = "=2.12.0"
  subscription_id = "fb39050f-a56b-46f3-ae84-9630e85abecb"
  client_id       = "802540fb-c633-4844-87e9-14316d98f153"
  client_secret   = "xxxx"
  tenant_id       = "5c384fed-84cc-44a6-b34a-b060bf102a6e"
  features {}
}

# terraform {
#   backend "azurerm" {
#     container_name = "workshop"
#     key            = "workshop.terraform.tfstate"
#   }
# }
