provider "azurerm" {
  features {}
}

// Import these resources that were manually created in the Azure Portal
resource "azurerm_resource_group" "import" {
  name     = "tstraub-myportal-rg"
  location = "westeurope"

  tags = {
    terraform = "true"
  }
}

resource "azurerm_storage_account" "import" {
  name                      = "tstraubstorageaccount"
  resource_group_name       = azurerm_resource_group.import.name
  location                  = "westeurope"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = {
    terraform = "true"
  }
}
