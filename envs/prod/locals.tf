locals {
    common_tags = {
        Project = var.project_name
        Environment = "Prod"
        ManagedBy = "Terraform"
        Owner = "Ajay"
        SubscriptionName = data.azurerm_subscription.current.display_name
    }
}