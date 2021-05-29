provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.40.0"
  features {}
  subscription_id = "ce133ce2-3196-48c0-9605-d846264e7806"
}

resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group
  location = "West Europe"
}

# resource "azurerm_storage_account" "san1" {
#   name                     = "santhoshteststorage"
#   resource_group_name      = azurerm_resource_group.rg1.name
#   location                 = azurerm_resource_group.rg1.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "staging"
#   }
# }


# resource "azurerm_virtual_network" "vnet1" {
#   name                = var.virtualnetwork_name
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name
#   address_space       = ["10.0.0.0/16"]
  
#   subnet {
#     name           = "production"
#     address_prefix = "10.0.1.0/24"
#   }

#   tags = {
#     environment = "Production"
#   }
# }


# resource "azurerm_network_interface" "main" {
#   name                = "${var.vmname}-nic"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name

#   ip_configuration {
#     name                          = "testconfiguration1"
#     subnet_id                     = azurerm_virtual_network.vnet1.[*].id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_virtual_machine" "main" {
#   name                  = "${var.prefix}-vm"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name
#   network_interface_ids = [azurerm_network_interface.main.id]
#   vm_size               = "Standard_DS1_v2"

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }
#   storage_os_disk {
#     name              = "myosdisk1"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "hostname"
#     admin_username = "testadmin"
#     admin_password = "Password1234!"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     environment = "staging"
#   }
# }
