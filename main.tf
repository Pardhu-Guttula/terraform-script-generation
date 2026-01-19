provider "azurerm" {
  features {}
  version = "~> 4.56.0"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier     = "Standard"
    size     = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    always_on = true
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server_name
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "database" {
  name                = var.sql_database_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "S0"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = "diag_setting"
  target_resource_id = azurerm_app_service.app_service.id

  enabled_log {
    category = "AppServiceHTTPLogs"
    retention_policy_days = 7
  }
  metric {
    category = "AllMetrics"
    retention_policy_days = 7
  }
}
