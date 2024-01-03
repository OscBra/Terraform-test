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

resource "azurerm_resource_group" "first" {
    name = "learn-tf-rg-norwayeast"
    location = "norwayeast"
}

resource "azurerm_resource_group" "second" {
    name = "learn-tf-rg-norwayeast2"
    location = "norwayeast"
}