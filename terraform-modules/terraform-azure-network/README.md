# Azure Virtual Network Terraform Module

This Terraform module provisions an **Azure Virtual Network (VNet)** along with one or more **subnets**, using a flexible input map. It supports tagging and integrates cleanly with other Azure networking modules.

---

## 📁 Module Structure

- `main.tf` – Provisions the VNet and dynamically defined subnets.
- `variables.tf` – Defines configurable input variables.
- `output.tf` – Outputs the VNet and subnet IDs.
- `versions.tf` – Specifies Terraform and provider version requirements.

---

## 🚀 Usage Example

```hcl
module "vnet" {
  source = "../terraform_modules/azure-vnet"

  vnet_name            = "dhdp-vnet"
  address_space        = ["10.10.0.0/16"]
  location             = "Canada Central"
  resource_group_name  = "dhdp-lab-resource-group"
  subnets = {
    "app-subnet"       = ["10.10.1.0/24"],
    "db-subnet"        = ["10.10.2.0/24"]
  }

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Replace `source` with the actual relative path to your module.

---

## 📥 Input Variables

| Name                  | Description                                   | Type                | Default | Required |
| --------------------- | --------------------------------------------- | ------------------- | ------- | -------- |
| `vnet_name`           | The name of the virtual network               | `string`            | —       | ✅        |
| `address_space`       | CIDR block(s) for the virtual network         | `list(string)`      | —       | ✅        |
| `location`            | Azure region for resource deployment          | `string`            | —       | ✅        |
| `resource_group_name` | Name of the resource group                    | `string`            | —       | ✅        |
| `subnets`             | Map of subnet names to their address prefixes | `map(list(string))` | —       | ✅        |
| `tags`                | Tags to apply to the VNet                     | `map(string)`       | `{}`    | ❌        |

---

## 📤 Outputs

| Output Name  | Description                       |
| ------------ | --------------------------------- |
| `vnet_id`    | ID of the created virtual network |
| `subnet_ids` | Map of subnet names to their IDs  |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* The specified resource group must already exist

---

## 💡 Notes

* Subnets are dynamically created based on the input map, supporting any number of custom subnets.
* This module is ideal as a base layer for complex networking setups (AKS, App Gateway, etc.).
* Use with NAT Gateway, NSG, and private endpoints for full network control.

---

## 📄 License

Maintained by the DHDP CloudOps team. Contributions and feedback welcome.
