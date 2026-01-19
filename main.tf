provider 'azurerm' {
  features {}
}

resource 'azurerm_resource_group' 'rg' {
  name     = 'rg-banking-portal'
  location = 'East US'
}

resource 'azurerm_app_service_plan' 'appserviceplan' {
  name                = 'appserviceplan'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = 'Standard'
    size = 'S1'
  }
}

resource 'azurerm_app_service' 'appservice' {
  name                = 'frontend-app'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
}

resource 'azurerm_api_management' 'apim' {
  name                = 'apim-instance'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = 'API Management Publisher'
  publisher_email     = 'api@management.com'
  sku_name            = 'Developer_1'
}

resource 'azurerm_sql_server' 'sqlserver' {
  name                         = 'sqlserver'
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = '12.0'
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource 'azurerm_sql_database' 'sqldb' {
  name                = 'sqldatabase'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = 'Basic'
}

resource 'azurerm_storage_account' 'storage' {
  name                     = 'storageaccount'
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = 'Standard'
  account_replication_type = 'LRS'
}

resource 'azurerm_notification_hub_namespace' 'nhnamespace' {
  name                = 'notificationhubns'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = 'Free'
}

resource 'azurerm_monitor' 'monitor' {
  name                = 'monitor-instance'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource 'azurerm_application_insights' 'appinsights' {
  name                = 'appInsightsInstance'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = 'web'
}

resource 'azurerm_key_vault' 'keyvault' {
  name                = 'keyvault'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource 'azurerm_traffic_manager_profile' 'trafficmanager' {
  name                   = 'traffic-manager-profile'
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  profile_status         = 'Enabled'
  traffic_routing_method = 'Performance'
  dns_config {
    relative_name = 'myapp'
    ttl           = 30
  }
  monitor_config {
    protocol = 'HTTP'
    port     = 80
    path     = '/'
  }
}

resource 'azurerm_backup_policy_vm' 'backup_policy_vm' {
  name                = 'daily-backup-policy'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  policy {
    schedule_policy {
      schedule_policy_type = 'Simple'
      schedule_daily {
        time               = '05:00'
        overwrite_recovery_point_hold_count = 5
      }
    }
    retention_policy {
      daily {
        count = 10
      }
    }
  }
}

resource 'azurerm_role_assignment' 'role_assignment' {
  scope                = data.azurerm_key_vault.keyvault.id
  role_definition_name = 'Reader'
  principal_id         = data.azurerm_client_config.current.object_id
}

resource 'azurerm_devops_project' 'devops_project' {
  name                = 'devopsproject'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  devops_organization = 'myorganization'
}

resource 'azurerm_frontdoor' 'frontdoor' {
  name                = 'frontend-door'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  routing_rule {
    name                                           = 'routing-rule'
    accepted_protocols                             = ['Https']
    patterns_to_match                              = ['/*']
    frontend_endpoints    = [azurerm_frontdoor_frontend_endpoint.fep1.id]
    forwarding_configuration {
      forwarding_protocol                  = 'HttpsOnly'
      backend_pool_required_certificate_name_check = 'Enabled'
    }
  }
}
