output "vm_id" {
  description = "The ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "public_ip_address" {
  description = "The Public IP address of the Linux Virtual Machine"
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_identity" {
  description = "The identity of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.identity
}

output "workspace_id" {
  description = "The Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.workspace.id
} 