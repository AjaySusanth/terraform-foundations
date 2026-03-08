terraform {
    required_version = ">=1.5.0"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }

  backend "azurerm" {
    resource_group_name = "terraform-mgmt-rg"
    storage_account_name = "tfstate2005"
    container_name = "tfstate"
    key = "dev.tfstate"
  }
}

provider "azurerm" {
    features {}
}