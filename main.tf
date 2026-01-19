provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-self-service-banking"
  location = "West Europe"
}

resource "azurerm_logic_app" "logicapp" {
  name                = "self-service-logicapp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_function_app" "function" {
  name                = "self-service-functionapp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  storage_account_name = azurerm_storage_account.sa.name
  tenant_id           = var.tenant_id
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

resource "azurerm_app_service_plan" "plan" {
  name                = "self-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "ssbstorageaccount"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "selfservicesqlserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = "selfservicedb"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "S0"
}

resource "azurerm_api_management" "api_management" {
  name                = "selfserviceapi"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "API Publisher"
  publisher_email     = "api-publisher@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_active_directory_domain_service" "aad" {
  name                = "aaDDSInstance"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  domain_name         = "example.com"
  sku                 = "Standard"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                         = "selfservicediagnosticsetting"
  target_resource_id           = azurerm_api_management.api_management.id
  log_analytics_workspace_id   = azurerm_log_analytics_workspace.law.id
  enabled_log {
    category = "GatewayLogs"
    retention_policy_days = 0
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "selfserviceLogAnalyticsWorkspace"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
}

resource "azurerm_notification_hub" "notification_hub" {
  name                = "selfservicehub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_key_vault" "key_vault" {
  name                = "selfservicekeyvault"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_name            = "standard"
}

resource "azurerm_security_center" "security_center" {
  tier = "Standard"
}

resource "azurerm_frontdoor" "front_door" {
  name                = "selfservicefrontdoor"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_traffic_manager" "traffic_manager" {
  name                = "selfservicetm"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_backup_policy_vm" "vm_policy" {
  name                = "selfservicevmpolicy"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_role_definition" "role_definition" {
  name                = "selfserviceroledefinition"
  resource_group_name = azurerm_resource_group.main.name
  scope               = azurerm_resource_group.main.id
}

resource "azurerm_devops_project" "devops_project" {
  name                 = "selfservicedevonproject"
  org_name             = "selfservicedevopsorg"
}resource "azurerm_api_management_api" "api" {
  name                = "selfserviceapi"
  resource_group_name = azurerm_resource_group.main.name
}
