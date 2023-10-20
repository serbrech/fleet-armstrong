resource "azurerm_resource_group" "test" {
  name     = "acctest8704"
  location = "westcentralus"
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "acctest2828"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_e4-2ads_v5"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_user_assigned_identity" "armstrong" {
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  name = "test-armstrong-231020"
}

