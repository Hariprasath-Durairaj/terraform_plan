###############################################################################
# terraform-azure-aks / main.tf
# Opinionated AKS module
#   • System-assigned managed identity
#   • RBAC enabled
#   • Optional Azure Monitor agent (OMS)
#   • Optional Application-Gateway Ingress Controller (AGIC)
###############################################################################

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group
  disable_local_accounts = var.disable_local_accounts
  # ── SYSTEM NODE-POOL ──────────────────────────────────────────────────────
  default_node_pool {
    name                        = var.default_node_pool.name
    vm_size                     = var.default_node_pool.vm_size
    temporary_name_for_rotation = var.default_node_pool.temporary_name_for_rotation
    enable_auto_scaling         = var.default_node_pool.enable_auto_scaling
    min_count                   = var.default_node_pool.min_count
    max_count                   = var.default_node_pool.max_count
    max_pods                    = var.default_node_pool.max_pods
    os_disk_size_gb             = var.default_node_pool.os_disk_size_gb
    node_labels                 = var.default_node_pool.node_labels
    vnet_subnet_id              = var.default_node_pool.vnet_subnet_id
    zones                       = var.default_node_pool.availability_zones
    tags                        = var.default_node_pool.tags
  }

  # ── IDENTITY & RBAC ───────────────────────────────────────────────────────
  identity {
    type = "SystemAssigned"
  }
  role_based_access_control_enabled = true

  # ── CLUSTER NETWORKING ────────────────────────────────────────────────────
  network_profile {
    network_plugin = var.network_plugin
    dns_service_ip = var.dns_service_ip
    service_cidr   = var.service_cidr
  }

# ── OPTIONAL: Application-Gateway Ingress Controller (AGIC) ───────────────
dynamic "ingress_application_gateway" {
  # emit the block only if var.enable_ingress_application_gateway == true
  for_each = var.enable_ingress_application_gateway ? [1] : []
  content {
    gateway_id = var.ingress_application_gateway_id   # required
    # subnet_id  = var.ingress_application_gateway_subnet_id  # ← add if you need it
  }
}


  # ── PRIVATE / API-SERVER SETTINGS ─────────────────────────────────────────
  private_cluster_enabled = var.private_cluster_enabled

  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }

  # ── OPTIONAL: Azure Monitor agent (OMS) ───────────────────────────────────
  dynamic "oms_agent" {
    for_each = var.enable_monitoring && var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = var.tags
}

###############################################################################
# ACR ↔ AKS kubelet role assignment
###############################################################################
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

###############################################################################
# USER NODE-POOLS (flexible map)
###############################################################################
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  for_each              = var.user_node_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id

  vm_size         = each.value.vm_size
  os_disk_size_gb = each.value.os_disk_size_gb
  node_count      = each.value.node_count
  max_pods        = each.value.max_pods
  mode            = each.value.mode

  node_labels    = each.value.node_labels
  vnet_subnet_id = each.value.vnet_subnet_id
  zones          = each.value.availability_zones
  tags           = each.value.tags
}
