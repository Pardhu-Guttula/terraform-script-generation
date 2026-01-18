provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-main"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-main"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "frontend" {
  name                = "frontend-webapp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_sql_server" "sql" {
  name                         = "sqlservermain"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_password
}

resource "azurerm_sql_database" "sqldb" {
  name                = "sqldb-main"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.sql.name
  requested_service_objective_name = "S0"
}

resource "azurerm_storage_account" "storage" {
  name                     = "storageaccountmain"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_function_app" "function" {
  name                       = "functionapp-main"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
}

resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name                       = "diag-monitor"
  target_resource_id         = azurerm_resource_group.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
      days    = 0
    }
  }
}
