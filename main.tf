provider 'azurerm' {
  features {}
  required_providers {
    azurerm = {
      source  = 'hashicorp/azurerm'
      version = '~> 4.56.0'
    }
  }
}
resource 'azurerm_resource_group' 'rg' {
  name     = 'rg-sample'
  location = 'East US'
}
resource 'azurerm_app_service_plan' 'asp' {
  name                = 'asp-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = 'Basic'
    size = 'B1'
  }
}
resource 'azurerm_app_service' 'app_service' {
  name                = 'app-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    always_on = true
  }
}
resource 'azurerm_key_vault' 'kv' {
  name                = 'kv-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = 'standard'
  soft_delete_enabled = true
}
resource 'azurerm_api_management' 'apim' {
  name                = 'apim-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = 'pub-name'
  publisher_email     = 'pub-email@example.com'
  sku_name            = 'Developer_1'
}
resource 'azurerm_sql_server' 'sql_server' {
  name                         = 'sql-server-sample'
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = '12.0'
  administrator_login          = 'adminuser'
  administrator_login_password = 'AdminPassword123!'
}
resource 'azurerm_sql_database' 'sql_db' {
  name                = 'sqldb-sample'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = 'S0'
}
resource 'azurerm_cosmosdb_account' 'cosmosdb' {
  name                = 'cosmosdb-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = 'Standard'
  kind                = 'GlobalDocumentDB'
  consistency_policy {
    consistency_level = 'Eventual'
  }
}
resource 'azurerm_notification_hub_namespace' 'nh_namespace' {
  name                = 'nh-namespace-sample'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = 'Basic'
    capacity = 1
  }
}
resource 'azurerm_notification_hub' 'nhub' {
  name                = 'nhub-sample'
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = azurerm_notification_hub_namespace.nh_namespace.name
}}