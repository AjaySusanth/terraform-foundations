output "latest_hostname" {
  value = azurerm_container_app.web.latest_revision_fqdn
}

output "principal_id" {
  value = azurerm_container_app.web.identity[0].principal_id
}
