resource "azurerm_subnet" "subnet" {
  name                 = local.subnetName
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnetCIDR]

### Ejemplo configuración avanzada Azure  
#   service_endpoints = ["Microsoft.KeyVault"]

#   delegation {
#     name = "Microsoft.Web.serverFarms"

#     service_delegation {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
###
}

