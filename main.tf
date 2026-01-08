provider "azurerm" {
  features {}
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku_name                    = "standard"
  tenant_id                   = var.tenant_id
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appservice"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "App"
  reserved            = true
  sku {
    tier = "PremiumV3"
    size = "P1v3"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    linux_fx_version = "PYTHON|3.8"
  }
}