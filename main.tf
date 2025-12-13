provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name               = var.monitor_name
  target_resource_id = azurerm_app_service.app_service.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  logs {
    category = "AppServiceConsoleLogs"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_eventhub_namespace" "eventhub_ns" {
  name                = var.eventhub_namespace
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = "Standard"
    capacity = 1
  }
}

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}
