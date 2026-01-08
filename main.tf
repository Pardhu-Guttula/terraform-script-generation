provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "example-appservice"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_api_management" "api_management" {
  name                = "example-apim"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "example-publisher"
  publisher_email     = "example@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_function_app" "function_app" {
  name                = "example-functionapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_sql_server" "sql_server" {
  name                = "example-sqlserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_username      = var.sql_admin_username
  admin_password      = var.sql_admin_password
  version             = "12.0"
}

resource "azurerm_sql_database" "sql_database" {
  name                = "example-sqldb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql_server.name
  requested_service_objective_name = "S0"
}

resource "azurerm_storage_account" "storage_account" {
  name                = "examplestorageaccount"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  account_tier        = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_log_profile" "log_profile" {
  name                = "example-logprofile"
  location            = azurerm_resource_group.rg.location
  categories          = ["Action", "Write", "Delete"]
  retention_policy {
    enabled = true
    days    = 30
  }
  storage_account_id = azurerm_storage_account.storage_account.id
}

resource "azurerm_key_vault" "key_vault" {
  name                = "example-keyvault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "example-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "load_balancer" {
  name                = "example-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  frontend_ip_configuration {
    name                          = "publicip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = "example-backuppolicy"
  location            = azurerm_resource_group.rg.location 
  resource_group_name = azurerm_resource_group.rg.name
  backup_schedule {
    frequency = "Daily"
    time_zone = "UTC"
  }
  retention_daily {
    count = 30
  }
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}

resource "azurerm_dev_test_lab" "dev_test_lab" {
  name                = "example-devtestlab"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
