# variable "appId" {
#   description = "Azure Kubernetes Service Cluster service principal"
# }

# variable "password" {
#   description = "Azure Kubernetes Service Cluster password"
# }

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}