provider 'azurerm' {
  features {}
}

resource 'azurerm_resource_group' 'main' {
  name     = var.resource_group_name
  location = var.location
}

resource 'azurerm_app_service_plan' 'plan' {
  name                = 'app_service_plan'
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier    = 'Standard'
    size    = 'S1'
  }
}

resource 'azurerm_app_service' 'app' {
  name                = 'webapp'
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  identity {
    type = 'SystemAssigned'
  }
  site_config {
    dotnet_framework_version = 'v4.0'
  }
  app_settings = {
    'WEBSITE_RUN_FROM_PACKAGE' = '1'
  }
}

resource 'azurerm_sql_server' 'sql' {
  name                         = 'my-sql-server'
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = '12.0'
  administrator_login          = 'mradminkey'
  administrator_login_password = var.sql_password
}

resource 'azurerm_sql_database' 'sqldb' {
  name                = 'mydatabase'
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.sql.name
  sku_name            = 'S0'
}

resource 'azurerm_monitor_diagnostic_setting' 'example' {
  name                       = 'example-diagnostic-setting'
  target_resource_id         = azurerm_app_service.app.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.example.id
  enabled_log {
    category = 'AppServiceHTTPLogs'
  }
  metric {
    category = 'AllMetrics'
  }
}
