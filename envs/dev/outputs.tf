output "resource_group_id" {
    description = "The id of the created resource group"
    value = azurerm_resource_group.rg.id
}

output "vnet_id" {
    description = "The ID of the created virtual network"
    value = module.network.vnet_id
}

output "app_url" {
  description = "The URL of the deployed container app"
  value       = "https://${module.app.latest_hostname}"
}
