resource "azurerm_key_vault" "kv" {
    name = "${var.project_name}-kv"
    location = var.location
    resource_group_name = var.resource_group_name
    tenant_id = var.tenant_id
    sku_name = "standard"

    enable_rbac_authorization = true
    tags = var.tags
}

resource "azurerm_role_assignment" "app_secrets_user" {
    scope = azurerm_key_vault.kv.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = var.app_principal_id
}