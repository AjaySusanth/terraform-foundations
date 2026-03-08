resource "azurerm_resource_group" "rg" {
    name = "${var.project_name}-rg"
    location = var.location
    tags = local.common_tags

    lifecycle {
      prevent_destroy = true
    }
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "${var.project_name}-vnet"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    "web-subnet" = "10.0.1.0/24"
    "db-subnet" = "10.0.2.0/24"
  }
  
  nsg_name            = "${var.project_name}-nsg"
  tags                = local.common_tags

  nsg_rules = [
    {
      name = "AllowHTTP"
      priority = 100
      direction = "Inbound"
      access = "Allow"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "80"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    },

    {
      name = "AllowHTTPS"
      priority = 110
      direction = "Inbound"
      access = "Allow"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "443"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    }

  ]
}

module "app" {
  source = "../../modules/app"

  project_name        = var.project_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = local.common_tags

  app_principal_id = module.app.principal_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  
}

module "aks" {
  source = "../../modules/aks"

  project_name = var.project_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = local.common_tags

  subnet_id = module.network.subnet_ids["web-subnet"]
}
