
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    type       = "VirtualMachineScaleSets"
    vm_size    = "Standard_D2_v2"

    vnet_subnet_id = azurerm_subnet.main.id
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
