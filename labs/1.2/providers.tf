provider "azurerm" {
  version         = "=2.15.0"
  # subscription_id = var.AZURE_SUBSCRIPTION_ID
  # client_id       = var.AZURE_CLIENT_ID
  # client_secret   = var.AZURE_CLIENT_SECRET
  # tenant_id       = var.AZURE_TENANT_ID
  features {}
}

provider "random" {
  version = "~> 2.1"
}