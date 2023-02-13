terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.18.0"
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
# reading from RG
data "azurerm_resource_group" "labrg" {
  name = var.resource_group_name

}
# adding postgresql database

resource "azurerm_postgresql_server" "labpostgres" {
  name = var.postgresql_server_name
  location = var.location
  resource_group_name = data.azurerm_resource_group.labrg.name

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

resource "azurerm_postgresql_database" "labpostgres" {
  name = "testdb"
  resource_group_name = data.azurerm_resource_group.labrg.name
  server_name = azurerm_postgresql_server.labpostgres.name
  charset = "UTF8"
  collation = "English_United States.1252"
}

data "azurerm_postgresql_server" "labpostgres" {
  name = var.postgresql_server_name
  resource_group_name = data.azurerm_resource_group.labrg.name
}

provider "postgresql" {
  host = data.azurerm_postgresql_server.labpostgres.fqdn
  port = 5432
  database = azurerm_postgresql_database.labpostgres.name
  username = data.azurerm_postgresql_server.labpostgres.administrator_login@azurerm_postgresql_database.labpostgres.name
  password = var.postgresql_admin_password
  connect_timeout = 15
  alias = "admindb"
}

resource "postgresql_role" "userrole" {
  provider = postgresql.admindb

  name = "user_role"
}