# Enable diagnostic settings for the VM
resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = "${var.vm_name}-diagnostics"
  target_resource_id        = azurerm_linux_virtual_machine.vm.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }

}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "${var.vm_name}-workspace"
  location           = var.location
  resource_group_name = var.resource_group_name
  sku                = "PerGB2018"
  retention_in_days  = 30

  tags = var.common_tags
}

# Install monitoring agent on VM
resource "azurerm_virtual_machine_extension" "monitoring_agent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id        = azurerm_linux_virtual_machine.vm.id
  publisher                 = "Microsoft.Azure.Monitor"
  type                      = "AzureMonitorLinuxAgent"
  type_handler_version      = "1.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "workspaceId": "${azurerm_log_analytics_workspace.workspace.workspace_id}"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "workspaceKey": "${azurerm_log_analytics_workspace.workspace.primary_shared_key}"
    }
PROTECTED_SETTINGS

  tags = var.common_tags
  
  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
} 