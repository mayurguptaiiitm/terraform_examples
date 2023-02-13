output "resource_group_name" {
  value = data.azurerm_resource_group.labrg.name
}

output "resource_group_location_name" {
    value = data.azurerm_resource_group.labrg.location 
}

output "resource_group_id" {
    value = data.azurerm_resource_group.labrg.id
}

output "resource_group_tags" {
    value = data.azurerm_resource_group.labrg.tags
}