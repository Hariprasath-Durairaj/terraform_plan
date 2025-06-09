# Azure Kubernetes Service (AKS) Terraform Module

This module provisions a fully configurable Azure Kubernetes Service (AKS) cluster, including:

- Default system node pool
- Optional user-defined node pools
- RBAC with Azure Active Directory integration
- OIDC and workload identity support
- Network and monitoring profiles
- Tagged resource deployment

---

## Usage Example

```hcl
module "aks" {
  source              = "../terraform-azure-aks"
  name                = "dhdp-qa-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dhdpqa"
  kubernetes_version  = "1.27.3"
  node_resource_group = "MC_dhdp-qa-rg_dhdp-qa-aks_canadacentral"

  default_node_pool_name                = "systemnp"
  default_node_pool_vm_size             = "Standard_DS2_v2"
  default_node_pool_node_count          = 2
  default_node_pool_enable_auto_scaling = true
  default_node_pool_min_count           = 2
  default_node_pool_max_count           = 5
  default_node_pool_os_disk_size_gb     = 50

  user_node_pools = {
    bitnobi = {
      vm_size             = "Standard_DS2_v2"
      node_count          = 2
      os_disk_size_gb     = 50
      enable_auto_scaling = true
      min_count           = 2
      max_count           = 5
      node_labels         = { "app" = "bitnobi" }
    }
  }

  identity_type              = "SystemAssigned"
  rbac_enabled               = true
  rbac_aad_managed           = true
  rbac_aad_admin_group_object_ids = ["<aad-group-id>"]
  oidc_issuer_enabled        = true
  workload_identity_enabled  = true

  network_plugin             = "azure"
  network_policy             = "azure"
  load_balancer_sku          = "standard"
  outbound_type              = "loadBalancer"
  dns_service_ip             = "10.2.0.10"
  service_cidr               = "10.2.0.0/24"
  docker_bridge_cidr         = "172.17.0.1/16"

  tags = {
    Environment = "QA"
    Project     = "DHDP"
  }
}
````

---

## Inputs

| Name                                    | Type           | Default            | Description                           |
| --------------------------------------- | -------------- | ------------------ | ------------------------------------- |
| `name`                                  | `string`       | —                  | Name of the AKS cluster               |
| `location`                              | `string`       | —                  | Azure region                          |
| `resource_group_name`                   | `string`       | —                  | Resource group for AKS                |
| `dns_prefix`                            | `string`       | —                  | DNS prefix for AKS                    |
| `kubernetes_version`                    | `string`       | —                  | Version of Kubernetes                 |
| `identity_type`                         | `string`       | `"SystemAssigned"` | Type of managed identity              |
| `rbac_enabled`                          | `bool`         | `true`             | Enable RBAC                           |
| `rbac_aad_managed`                      | `bool`         | `true`             | Use AAD-managed RBAC                  |
| `rbac_aad_admin_group_object_ids`       | `list(string)` | `[]`               | AAD group object IDs for admin access |
| `oidc_issuer_enabled`                   | `bool`         | `true`             | Enable OIDC issuer                    |
| `workload_identity_enabled`             | `bool`         | `true`             | Enable workload identity              |
| `default_node_pool_name`                | `string`       | —                  | Name for the default node pool        |
| `default_node_pool_vm_size`             | `string`       | —                  | VM size for default node pool         |
| `default_node_pool_node_count`          | `number`       | —                  | Initial node count                    |
| `default_node_pool_enable_auto_scaling` | `bool`         | `true`             | Enable autoscaling for default pool   |
| `default_node_pool_min_count`           | `number`       | —                  | Minimum node count for autoscaling    |
| `default_node_pool_max_count`           | `number`       | —                  | Maximum node count for autoscaling    |
| `default_node_pool_os_disk_size_gb`     | `number`       | `50`               | OS disk size in GB                    |
| `user_node_pools`                       | `map(object)`  | `{}`               | Map of user node pool configurations  |
| `network_plugin`                        | `string`       | `"azure"`          | Network plugin to use                 |
| `network_policy`                        | `string`       | `"azure"`          | Network policy to apply               |
| `load_balancer_sku`                     | `string`       | `"standard"`       | Load balancer SKU                     |
| `outbound_type`                         | `string`       | `"loadBalancer"`   | Outbound type                         |
| `dns_service_ip`                        | `string`       | —                  | DNS service IP address                |
| `service_cidr`                          | `string`       | —                  | CIDR block for Kubernetes services    |
| `docker_bridge_cidr`                    | `string`       | —                  | CIDR for Docker bridge network        |
| `tags`                                  | `map(string)`  | `{}`               | Resource tags                         |

---

## Outputs

| Name               | Description                       |
| ------------------ | --------------------------------- |
| `aks_id`           | ID of the AKS cluster             |
| `kube_config`      | Raw kubeconfig for kubectl access |
| `kube_config_file` | Structured kubeconfig object      |
| `aks_fqdn`         | AKS cluster FQDN                  |

---

## Notes

* This module supports both system and user node pools.
* AAD integration and workload identity are optional but recommended for production.
* Ensure correct `rbac_aad_admin_group_object_ids` are passed if RBAC is enabled.

---
