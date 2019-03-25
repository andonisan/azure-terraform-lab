resource "azurerm_resource_group" "main" {
  for_each = var.rg_names_set
  name     = "lab-2-5-${lower(each.key)}-rg"
  location = each.value
}

