# 1. The Log Analytics Workspace (The "Black Box")
resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${var.project_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# 2. The Container App Environment (The "Garage")
resource "azurerm_container_app_environment" "env" {
  name                       = "${var.project_name}-aca-env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  tags                       = var.tags
}

resource "azurerm_container_app" "web" {
    name = "${var.project_name}-app"
    container_app_environment_id = azurerm_container_app_environment.env.id
    resource_group_name = var.resource_group_name
    revision_mode = "Single"

    identity {
        type = "SystemAssigned"
    }

    template {
        container {
            name = "nginx"
            image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu = 0.25
            memory = "0.5Gi"
        }
    }

    ingress {
        allow_insecure_connections = false
        external_enabled = true
        target_port = 80
        traffic_weight {
            percentage = 100
            latest_revision = true
        }
    }
  
}



