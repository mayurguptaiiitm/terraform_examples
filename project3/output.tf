# output "resource_group_name" {
#   value = data.azurerm_resource_group.name.name
# }

output "postgresql_fqdn_name" {
    value = data.azurerm_postgresql_server.labpostgres.fqdn
}

output "postgresql_server_name" {
    value = data.azurerm_postgresql_server.labpostgres.name
}

output "postgresql_server_admin" {
    value = data.azurerm_postgresql_server.labpostgres.administrator_login
}

output "postgresql_database_name" {
    value = azurerm_postgresql_database.labpostgres.name
  
}

output "postgresql_database_server_name" {
    value = azurerm_postgresql_database.labpostgres.server_name
  
}

