# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-vnet"
  resource_group_name = var.resource_group_name
  location           = var.location
  address_space      = var.vnet_address_space

  tags = var.common_tags
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.project_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}

# Create Public IP
resource "azurerm_public_ip" "pip" {
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location           = var.location
  allocation_method  = "Dynamic"
  tags               = var.common_tags
}

# Create Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-nsg"
  location           = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_ip
    destination_address_prefix = "*"
  }

  tags = var.common_tags
}

# Create Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location           = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.common_tags
}

# Connect NSG to NIC
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location           = var.location
  size               = var.vm_size
  admin_username     = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  provision_vm_agent = true

  tags = var.common_tags
}
