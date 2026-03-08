resource "azurerm_kubernetes_cluster" "k8s" {
    name = "${var.project_name}-aks"
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "${var.project_name}-k8s"

    kubernetes_version = "1.34"

    default_node_pool {
      name = "system"
      node_count = 1
      vm_size = "Standard_B2pls_v2"
      vnet_subnet_id = var.subnet_id
    }

    identity {
      type =  "SystemAssigned"
    }

    network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
      service_cidr      = "172.16.0.0/16"   # A completely separate range for K8s services
      dns_service_ip    = "172.16.0.10"     # Must be an IP inside the service_cidr
    }

    tags = var.tags
  
}