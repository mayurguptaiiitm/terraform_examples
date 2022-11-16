
provider "azurerm" {
    features {
    }
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    skip_provider_registration = true
}
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=2.36.0"
    }
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name = "abc-aks"
  location = "eastus"
  resource_group_name = var.resource_group_name
  dns_prefix = "abc-k8s"

  default_node_pool {
    name = "default"
    node_count = 2
    vm_size = "Standard_B2s"
    #os_disk_size_gb = 0
  }

  # service_principal {
  #   client_id = var.appId
  #   client_secret = var.password
  # }
  #role_based_access_control_enabled = true
  identity { type = "SystemAssigned" }
  tags = {
    "environment" = "demo"
  }
}
# resource "azurerm_resource_group" "rg" {
#     name = "myFirstResourceGroup"
#     location = "eastus"
  
# }

# data "azurerm_kubernetes_cluster" "akscluster" {
#   name                = "abc-aks"
#   resource_group_name = "1-da4331c9-playground-sandbox"
# }

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  #version    = var.ingress_nginx_helm_version
  namespace         = "nginx-ingress"
  create_namespace  = true
  dependency_update = true
  #values            = [file("${path.module}/templates/ingressvalues.yaml")]
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  # version    = "v1.7.1"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name

  set {
    name  = "installCRDs"
    value = "true"
  }
}