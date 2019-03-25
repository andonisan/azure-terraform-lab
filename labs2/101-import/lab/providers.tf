provider "azurerm" {
  version         = "=2.12.0"
  subscription_id = "b4257979-755f-4311-ba59-6e835574b1d9"
  client_id       = "31662d49-b382-4e08-acc8-27336983f97c"
  client_secret   = "b1de2b83-9083-444e-b732-ef1034c42152"
  tenant_id       = "7746325c-0dd0-4e2c-89a7-dd24026d484a"
  features {}
}

terraform {
  backend "azurerm" {
    container_name = "workshop"
    key            = "workshop.terraform.tfstate"
  }
}
