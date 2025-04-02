# Create Action Group for alerts
resource "azurerm_monitor_action_group" "vm_action_group" {
  name                = "${var.vm_name}-action-group"
  resource_group_name = var.resource_group_name
  short_name         = "vmactions"

  email_receiver {
    name                    = "admin"
    email_address          = var.alert_email
    use_common_alert_schema = true
  }
}

# CPU Usage Alert
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "${var.vm_name}-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when CPU usage exceeds threshold"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80

    dimension {
      name     = "VMName"
      operator = "Include"
      values   = [var.vm_name]
    }
  }

  window_size        = "PT15M"  # 15 minutes
  frequency          = "PT5M"   # Check every 5 minutes

  action {
    action_group_id = azurerm_monitor_action_group.vm_action_group.id
  }

  severity = 2  # 0 = Critical, 1 = Error, 2 = Warning, 3 = Informational, 4 = Verbose
}

# Available Memory Alert
resource "azurerm_monitor_metric_alert" "memory_alert" {
  name                = "${var.vm_name}-memory-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when available memory is low"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 536870912

    dimension {
      name     = "VMName"
      operator = "Include"
      values   = [var.vm_name]
    }
  }

  window_size = "PT15M"
  frequency   = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.vm_action_group.id
  }

  severity = 2
}

# Disk Usage Alert
resource "azurerm_monitor_metric_alert" "disk_alert" {
  name                = "${var.vm_name}-disk-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when disk usage is high"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Disk Read Bytes"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1000000000

    dimension {
      name     = "VMName"
      operator = "Include"
      values   = [var.vm_name]
    }
  }

  window_size = "PT15M"
  frequency   = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.vm_action_group.id
  }

  severity = 2
}

# VM Availability Alert
resource "azurerm_monitor_metric_alert" "availability_alert" {
  name                = "${var.vm_name}-availability-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when VM becomes unavailable"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "VmAvailabilityMetric"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100

    dimension {
      name     = "VMName"
      operator = "Include"
      values   = [var.vm_name]
    }
  }

  window_size = "PT5M"
  frequency   = "PT1M"

  action {
    action_group_id = azurerm_monitor_action_group.vm_action_group.id
  }

  severity = 0  # Critical severity for availability issues
}

# Network In/Out Alert
resource "azurerm_monitor_metric_alert" "network_alert" {
  name                = "${var.vm_name}-network-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when network usage is high"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Network In Total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1000000000

    dimension {
      name     = "VMName"
      operator = "Include"
      values   = [var.vm_name]
    }
  }

  window_size = "PT15M"
  frequency   = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.vm_action_group.id
  }

  severity = 2
} 