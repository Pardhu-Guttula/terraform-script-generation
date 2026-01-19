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

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-appservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_sql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "H@Sh1CoR3!"
}

resource "azurerm_sql_database" "example" {
  name                = "example-sqldatabase"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "S0"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageaccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_notification_hub_namespace" "example" {
  name                = "example-notificationhubnamespace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku {
    tier  = "Standard"
  }
}

resource "azurerm_monitor" "example" {
  name                = "example-monitor"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_application_insights" "example" {
  name                = "example-appinsights"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  application_type    = "web"
}

resource "azurerm_key_vault" "example" {
  name                = "example-keyvault"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "standard"
}

resource "azurerm_security_center" "example" {
  name                = "example-securitycenter"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_front_door" "example" {
  name                = "example-frontdoor"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_traffic_manager_profile" "example" {
  name                = "example-trafficmanager"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  traffic_routing_method = "Performance"
}

resource "azurerm_backup_policy_vm" "example" {
  name                = "example-backup"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_role_definition" "example" {
  name        = "example-roledb-admin"
  scope       = azurerm_sql_server.example.id
  permissions {
    actions   = ["*"]
    not_actions = []
  }
  assignable_scopes = [azurerm_resource_group.example.id]
}

resource "azurerm_devops_project" "example" {
  name                = "example-devops-project"
  location            = azurerm_resource_group.example.location
}
