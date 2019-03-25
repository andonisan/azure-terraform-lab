resource "azurerm_resource_group" "import" {
  name     = "lab"
  location = "westeurope"
  tags = {
    DIV            = "Workshop",
    BU             = "Workshop",
    SITEIT_Name    = "Workshop",
    Service_Type   = "Workshop",
    IT_Owner_Group = "Workshop",
    Business_Owner = "Workshop",
    Project        = "Workshop"
  }
}

resource "azurerm_storage_account" "import" {
  name                      = "stworkshopgonvarri"
  resource_group_name       = azurerm_resource_group.import.name
  location                  = "westeurope"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  tags = {
    DIV            = "Workshop",
    BU             = "Workshop",
    SITEIT_Name    = "Workshop",
    Service_Type   = "Workshop",
    IT_Owner_Group = "Workshop",
    Business_Owner = "Workshop",
    Project        = "Workshop"
  }
}
