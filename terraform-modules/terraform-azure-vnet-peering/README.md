# Azure VNet Peering Terraform Module

This Terraform module facilitates the creation of Azure Virtual Network (VNet) peering between two VNets, enabling seamless connectivity across the Microsoft backbone network.

## 📁 Module Structure

* `main.tf` – Defines the `azurerm_virtual_network_peering` resources for both directions.
* `variables.tf` – Declares input variables for customization.
* `output.tf` – Outputs relevant resource identifiers.
* `versions.tf` – Specifies required Terraform and provider versions.

## 🚀 Usage

```hcl
module "vnet_peering" {
  source = "../terraform_modules/terraform-azure-vnet-peering"

  source_vnet_name           = "vnet-hub"
  source_resource_group_name = "rg-hub"
  source_vnet_id             = azurerm_virtual_network.vnet_hub.id

  remote_vnet_name           = "vnet-spoke"
  remote_resource_group_name = "rg-spoke"
  remote_vnet_id             = azurerm_virtual_network.vnet_spoke.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
```



Replace `source` with the correct relative path to this module in your project.

## 📥 Input Variables

| Name                           | Description                                             | Type          | Default | Required |   |
| ------------------------------ | ------------------------------------------------------- | ------------- | ------- | -------- | - |
| `source_vnet_name`             | Name of the source VNet                                 | `string`      | n/a     | ✅        |   |
| `source_resource_group_name`   | Name of the resource group containing the source VNet   | `string`      | n/a     | ✅        |   |
| `source_vnet_id`               | ID of the source VNet                                   | `string`      | n/a     | ✅        |   |
| `remote_vnet_name`             | Name of the remote VNet                                 | `string`      | n/a     | ✅        |   |
| `remote_resource_group_name`   | Name of the resource group containing the remote VNet   | `string`      | n/a     | ✅        |   |
| `remote_vnet_id`               | ID of the remote VNet                                   | `string`      | n/a     | ✅        |   |
| `allow_virtual_network_access` | Whether to allow VNet access from the remote VNet       | `bool`        | `true`  | ❌        |   |
| `allow_forwarded_traffic`      | Whether to allow forwarded traffic from the remote VNet | `bool`        | `false` | ❌        |   |
| `allow_gateway_transit`        | Whether to allow gateway transit                        | `bool`        | `false` | ❌        |   |
| `use_remote_gateways`          | Whether to use remote gateways                          | `bool`        | `false` | ❌        |   |
| `tags`                         | Tags to apply to the peering resources                  | `map(string)` | `{}`    | ❌        |   |

## 📤 Outputs

| Output Name   | Description                               |   |
| ------------- | ----------------------------------------- | - |
| `peering_ids` | IDs of the created VNet peering resources |   |

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`

## 🛡️ Best Practices

* Ensure that both VNets are not overlapping in address space.
* Configure peering in both directions to establish full connectivity.
* Use appropriate settings for `allow_gateway_transit` and `use_remote_gateways` based on your network topology.

## 📄 License

This module is maintained by the DHDP CloudOps team. Contributions and feedback are welcome.
