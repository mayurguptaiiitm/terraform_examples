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

# This part of the code will read data from the existing resource group 
# and provide the details in the outputs.tf file
data "azurerm_resource_group" "labrg" {
  name = var.resource_group_name

}