# Azure Private DNS Terraform Module

This Terraform module facilitates the creation and management of Azure Private DNS Zones, including optional linkage to Virtual Networks (VNets).

## 📁 Module Structure

* `main.tf` – Defines the primary resources: `azurerm_private_dns_zone` and `azurerm_private_dns_zone_virtual_network_link`.
* `variables.tf` – Declares input variables for customization.
* `output.tf` – Outputs relevant resource identifiers.
* `versions.tf` – Specifies required Terraform and provider versions.([GitHub][1])

## 🚀 Usage

```hcl
module "private_dns" {
  source = "../terraform_modules/terraform-azure-private-dns"

  dns_zone_name       = "privatelink.example.com"
  resource_group_name = "example-rg"
  vnet_ids            = ["<vnet-id-1>", "<vnet-id-2>"]
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
```



Replace `source` with the correct relative path to this module in your project.([Stack Overflow][2])

## 📥 Input Variables

| Name                  | Description                                           | Type           | Default | Required |   |
| --------------------- | ----------------------------------------------------- | -------------- | ------- | -------- | - |
| `dns_zone_name`       | Name of the Private DNS Zone                          | `string`       | n/a     | ✅        |   |
| `resource_group_name` | Name of the resource group                            | `string`       | n/a     | ✅        |   |
| `vnet_ids`            | List of Virtual Network IDs to link with the DNS Zone | `list(string)` | `[]`    | ❌        |   |
| `tags`                | Tags to apply to resources                            | `map(string)`  | `{}`    | ❌        |   |

## 📤 Outputs

| Output Name     | Description                                |   |
| --------------- | ------------------------------------------ | - |
| `dns_zone_id`   | The ID of the created Private DNS Zone     |   |
| `dns_zone_name` | The name of the created Private DNS Zone   |   |
| `vnet_link_ids` | List of IDs for the VNet links established |   |

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`

## 🛡️ Best Practices

* Ensure that the VNets specified in `vnet_ids` are in the same region as the DNS Zone for optimal performance.
* Use meaningful naming conventions for DNS Zones to reflect their purpose and scope.
* Regularly review and update DNS records to maintain accuracy.([Microsoft Learn][3])

## 📄 License

This module is maintained by the DHDP CloudOps team. Contributions and feedback are welcome.
