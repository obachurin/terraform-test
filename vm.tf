
# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westeurope"
}

# Use the Linux VM module
module "linux_vm" {
  source = "./modules/linux-vm"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = var.vm_name
  project_name        = var.project_name
  alert_email         = var.alert_email
  vm_size             = var.vm_size
  bastion_ip          = var.bastion_ip

  common_tags = local.common_tags
}
