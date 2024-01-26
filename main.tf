terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
features {}
}

resource "azurerm_resource_group" "main" {
  name = "learn-tf-rg-norwayeast"
  location = "norwayeast"
}

resource "azurerm_virtual_network" "main" {
  name = "learn-tf-vnet-norwayeast"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["10.0.0.0/16"]
}