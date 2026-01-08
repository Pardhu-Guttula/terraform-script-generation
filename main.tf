provider "azurerm" {
  features {}
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "example-appservice"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    always_on = true
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.app_insights.connection_string
  }
}

resource "azurerm_application_insights" "app_insights" {
  name                = "example-appinsights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "examplestorageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = "example-diagnostic-setting"
  target_resource_id = azurerm_application_insights.app_insights.id
  eventhub_authorization_rule_id = "event_hubs_auth_rule_id"
  log_analytics_workspace_id     = "workspace_id"

  enabled_log {
    category = "Administrative"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_key_vault" "kv" {
  name                        = "example-keyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
}

resource "azurerm_api_management" "api_management" {
  name                = "example-api-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "examplepublisher"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_service_bus_namespace" "namespace" {
  name                = "example-sbnamespace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

resource "azurerm_service_bus_queue" "queue" {
  name                = "example-sbqueue"
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = azurerm_service_bus_namespace.namespace.name
}
