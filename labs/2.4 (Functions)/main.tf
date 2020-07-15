resource "azurerm_resource_group" "main" {
  name     = "rg-${local.prefix}"
  location = "westeurope"
}

resource "azurerm_management_lock" "can_not_delete" {
  count      = var.full_access ? 1 : 0
  name       = "CanNotDelete"
  scope      = azurerm_resource_group.main.id
  lock_level = "CanNotDelete"
}

resource "azurerm_management_lock" "read_only" {
  count      = var.full_access ? 0 : 1
  name       = "ReadOnly"
  scope      = azurerm_resource_group.main.id
  lock_level = "ReadOnly"
}
