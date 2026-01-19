resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "mysqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "example" {
  name                = "mysqldatabase"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "S0"
}

resource "azurerm_function_app" "example" {
  name                       = "examplefa"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "linux"
  version                    = "~3"
}

resource "azurerm_app_service_plan" "example" {
  name                = "exampleasp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_api_management" "example" {
  name                = "exampleapim"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "My Company"
  publisher_email     = "company@security.org"
  sku_name            = "Developer_1"
}

resource "azurerm_ad_b2c_directory" "example" {
  name  = "MyB2CDirectory"
  location = azurerm_resource_group.example.location
  sku_name = "P1"
}

resource "azurerm_notification_hub_namespace" "example" {
  name                              = "example-ns"
  resource_group_name               = azurerm_resource_group.example.name
  location                          = azurerm_resource_group.example.location
  sku_name                          = "Standard"
}

resource "azurerm_notification_hub" "example" {
  name                              = "example-hub"
  resource_group_name               = azurerm_resource_group.example.name
  namespace_name                    = azurerm_notification_hub_namespace.example.name
}

resource "azurerm_monitor" "example" {
  name                = "examplemonitor"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_application_insights" "example" {
  name                = "exampleappi"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tenant_id                   = var.tenant_id
}

resource "azurerm_security_center_contact" "example" {
  name                         = "example"
  email                       = "example@security.org"
}

resource "azurerm_front_door" "example" {
  name                = "examplefd"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_traffic_manager_profile" "example" {
  name                = "exampletm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_backup_policy_vm" "example" {
  name                = "examplebackup"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_role_definition" "example" {
  name        = var.role_definition_name
  scope       = data.azurerm_subscription.primary.id
  description = "This is an example role definition"
  permissions {
    actions     = [
      "*"]
    not_actions = []
  }
  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

resource "azurerm_devops_project" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  organization_name   = var.organization_name
  version_control {
    git = true
  }
}

resource "azurerm_role_assignment" "example" {
  name                = "example"
  scope               = data.azurerm_subscription.primary.id
  principal_id        = var.principal_id
}
