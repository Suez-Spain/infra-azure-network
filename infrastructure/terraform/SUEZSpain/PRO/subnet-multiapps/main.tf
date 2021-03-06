locals {
  subnetName      = "${var.prefix}-${upper(var.environment)}${lower(var.project)}-SUBNET"
}

data "azurerm_resource_group" "vnetrg" {
  name     = var.vnet_resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnetName
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnetCIDR]

### Ejemplo configuración avanzada Azure  
  service_endpoints = ["Microsoft.KeyVault"]

#   delegation {
#     name = "Microsoft.Web.serverFarms"

#     service_delegation {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
###
}

resource "azurerm_route_table" "tr" {
  name                = "${var.prefix}-${upper(var.environment)}-${upper(var.project)}-TRutas"
  resource_group_name = data.azurerm_resource_group.vnetrg.name
  location            = data.azurerm_resource_group.vnetrg.location

  # En teoria segueixen les rutes definieds encara que es propaguin. 
  disable_bgp_route_propagation = false

  # For aks internet needed... 
  route {
    name                   = "Internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }
  
  # route {
  #   name                    = "DEFAULT_Paloalto"
  #   address_prefix          = "0.0.0.0/0"
  #   next_hop_type           = "VirtualAppliance"
  #   next_hop_in_ip_address  = "10.36.55.252"
  # }

  route {
    name                    = "LAN_A"
    address_prefix          = "10.0.0.0/8"
    next_hop_type           = "VirtualAppliance"
    next_hop_in_ip_address  = "10.36.55.252"
  }
  
  route {
    name                    = "LAN_B"
    address_prefix          = "172.16.0.0/12"
    next_hop_type           = "VirtualAppliance"
    next_hop_in_ip_address  = "10.36.55.252"
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "azurerm_subnet_route_table_association" "tr_subnet_association" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.tr.id
}