resource "azurerm_resource_group" "rg" {
    name = "${var.project_name}-rg"
    location = var.location
    tags = local.common_tags
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  vnet_name = "${var.project_name}-vnet"
  address_space=["10.0.0.0/16"]
  subnet_name = "web-subnet"
  subnet_prefix = ["10.0.1.0/24"]
  nsg_name = "${var.project_name}-nsg"
  tags = local.common_tags
}
