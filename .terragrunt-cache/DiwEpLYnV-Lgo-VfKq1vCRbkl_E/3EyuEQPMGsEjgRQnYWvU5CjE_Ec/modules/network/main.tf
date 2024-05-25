provider "azurerm" {
  features {
  }
}



resource "azurerm_resource_group" "vnet_rgs" {
  for_each = var.spoke_networking
  name     = each.value.rg_name
  location = each.value.location
}


resource "azurerm_virtual_network" "spoke_vnet" {
  depends_on = [azurerm_resource_group.vnet_rgs]
  for_each   = var.spoke_networking

  name                = each.value.virtual_network_name
  location            = each.value.location
  address_space       = [each.value.vnet_address_space]
  resource_group_name = each.value.rg_name
  tags = {
    Name = each.value.virtual_network_name
  }
}

resource "azurerm_subnet" "subnets" {
  for_each   = local.subnets
  depends_on = [azurerm_virtual_network.spoke_vnet]

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = [each.value.subnet_address]

}

resource "azurerm_network_security_group" "nsgs" {
  for_each = local.nsgs

  name                = each.value.nsgs.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assign" {
  for_each   = local.nsgs
  depends_on = [azurerm_subnet.subnets]

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}
