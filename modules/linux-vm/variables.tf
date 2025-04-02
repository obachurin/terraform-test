variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region location"
  default     = "westeurope"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "my-project"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
  default     = "Standard_DS1_v2"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type        = list(string)
  description = "Address prefix for Subnet"
  default     = ["10.0.1.0/24"]
}

variable "bastion_ip" {
  type        = string
  description = "IP address of the Bastion host"
}

variable "alert_email" {
  type        = string
  description = "Email address for alerts"
}
