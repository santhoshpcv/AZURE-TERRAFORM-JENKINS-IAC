provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.40.0"
  features {}
  subscription_id = "5474c111-7597-430a-80bf-2e3a19e91895"
}

terraform {
  backend "azurerm" {
    resource_group_name   = "pani_rg"
    storage_account_name  = "panistorage"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    access_key= "le36dN2mOupSvWUPfkVz/VJp1O0naZQbzT9QPEo6P/Kb8yJOakh9wp+kfLvKLQJChY3kaYYZiEICrZAJRAW5Hw=="
  }
}



resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group
  location = "West Europe"
}

resource "azurerm_network_security_group" "acusnsg" {
  for_each = toset(var.nsgs) 
  name                = each.value
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

locals {
  subnets=[{
      name           = "production"
      address_prefix = "10.0.1.0/24"
      nsgname = "prd_nsg"

  },
  {

    name           = "Test"
    address_prefix = "10.0.2.0/24"
    nsgname = "test_nsg"
  },
  
  {
    name           = "Dev"
    address_prefix = "10.0.3.0/24"
    nsgname = "dev_nsg"
  }
  
  ]
}


resource "azurerm_virtual_network" "vnet1" {
  name                = var.virtualnetwork_name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  
  
dynamic "subnet"{
  for_each= local.subnets
  content {
    name= subnet.value.name
    address_prefix = subnet.value.address_prefix
    security_group =azurerm_network_security_group.acusnsg[subnet.value.nsgname].id
  } 
 }
  
  tags = {
    environment = "Production"
  }


}
