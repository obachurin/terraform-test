variable "location" {
  type        = string
  description = "Azure region location"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "my-linux-vm-rg"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "alert_email" {
  type        = string
  description = "Email address for alerts"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "bastion_ip" {
  type        = string
  description = "IP address of the Bastion host"
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
  default     = "Standard_B1s"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
