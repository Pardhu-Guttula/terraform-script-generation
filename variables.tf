variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix of the subnet"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "blob_name" {
  description = "The name of the blob"
  type        = string
}

variable "blob_source" {
  description = "The path to the source file for the blob"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription"
  type        = string
}

variable "app_insights_name" {
  description = "The name of the Application Insights instance"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "web_app_name" {
  description = "The name of the web app"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan"
  type        = string
}

variable "web_app_settings" {
  description = "A map of settings to configure for the web app"
  type        = map(string)
}

variable "function_app_name" {
  description = "The name of the Function App"
  type        = string
}

variable "function_app_settings" {
  description = "A map of settings to configure for the function app"
  type        = map(string)
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "vm_admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}

variable "nic_name" {
  description = "The name of the Network Interface"
  type        = string
}
