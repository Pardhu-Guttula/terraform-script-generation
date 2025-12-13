variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed"
  type        = string
  default     = "East US"
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

variable "subnet_address" {
  description = "The address prefix of the subnet"
  type        = string
}

variable "asp_name" {
  description = "The name of the App Service plan"
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "blob_container_name" {
  description = "The name of the blob container"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription"
  type        = string
}

variable "function_app_name" {
  description = "The name of the Function App"
  type        = string
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
  sensitive   = true
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}
