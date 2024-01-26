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

#Creates virtual network
resource "azurerm_virtual_network" "main" {
  name = "learn-tf-vnet-norwayeast"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["10.0.0.0/16"]
}

#Creates subnet no the vnet
resource "azurerm_subnet" "main" {
  name = "learn-tf-subnet-norwayeast"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = azurerm_resource_group.main.name
  address_prefixes = ["10.0.0.0/24"]
}

#Creates network interface card, nic
resource "azurerm_network_interface" "internal" {
  name = "learn-tf-NIC-int-norwayeast"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "main" {
  name = "learn-tf-vm-norwayeast"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size = "Standard_B1s"
  admin_username = "user.admin"
  admin_password = "enter-password"

  network_interface_ids = [
    azurerm_network_interface.internal.id
  ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftwindowsServer"
    offer = "WindowsServer"
    sku = "2016-DataCenter"
    version = "latest"
  }
}