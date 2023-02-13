terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    client_id = var.client_id
    client_secret = var.secret
    skip_provider_registration = true
}

# adding postgresql database

resource "azurerm_postgresql_server" "labpostgres" {
  name = var.postgresql_server_name
  location = var.location
  resource_group_name = var.resource_group_name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = var.postgresql_admin_name
  administrator_login_password = var.postgresql_admin_password
  version                      = "11"
  ssl_enforcement_enabled      = true
}