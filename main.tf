terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "banking-portal-rg"
  location = "East US"
}

# Authentication and Security
resource "azurerm_key_vault" "kv" {
  name                = "banking-keyvault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
}

resource "azurerm_app_service_environment_v3" "ase" {
  name                = "banking-ase"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Data Layer
resource "azurerm_sql_server" "sql" {
  name                         = "bankingsqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.sql_password.result
}

resource "azurerm_sql_database" "sql_db" {
  name                = "banking-sqldb"
  resource_group_name = azurerm_sql_server.sql.resource_group_name
  location            = azurerm_sql_server.sql.location
  server_name         = azurerm_sql_server.sql.name
  requested_service_objective_name = "S0"
}

resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "banking-cosmosdb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}

resource "azurerm_storage_account" "storage" {
  name                     = "bankingstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Monitoring and Logging
resource "azurerm_monitor_diagnostic_setting" "diag" {
  name                       = "banking-diag"
  target_resource_id         = azurerm_app_service_environment_v3.ase.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  enabled_log {
    category = "AppServiceHTTPLogs"
  }
  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "banking-log-analytics"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
