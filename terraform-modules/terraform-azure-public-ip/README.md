# Azure Public IP Terraform Module

This Terraform module facilitates the creation and management of Azure Public IP addresses, supporting both static and dynamic allocation methods, as well as Basic and Standard SKUs.

## 📁 Module Structure

* `main.tf` – Defines the `azurerm_public_ip` resource.
* `variables.tf` – Declares input variables for customization.
* `output.tf` – Outputs relevant resource identifiers.
* `versions.tf` – Specifies required Terraform and provider versions.

## 🚀 Usage

```hcl
module "public_ip" {
  source              = "../terraform_modules/terraform-azure-public-ip"

  public_ip_name      = ["example-pip"]
  location            = "Canada Central"
  resource_group_name = "example-rg"
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
```



Replace `source` with the correct relative path to this module in your project.

## 📥 Input Variables

| Name                  | Description                                      | Type           | Default   | Required |   |
| --------------------- | ------------------------------------------------ | -------------- | --------- | -------- | - |
| `public_ip_name`      | Name(s) of the Public IP address(es)             | `list(string)` | n/a       | ✅        |   |
| `location`            | Azure region where the Public IP will be created | `string`       | n/a       | ✅        |   |
| `resource_group_name` | Name of the resource group                       | `string`       | n/a       | ✅        |   |
| `allocation_method`   | Allocation method: `Static` or `Dynamic`         | `string`       | `Dynamic` | ❌        |   |
| `sku`                 | SKU of the Public IP: `Basic` or `Standard`      | `string`       | `Basic`   | ❌        |   |
| `tags`                | Tags to apply to the Public IP                   | `map(string)`  | `{}`      | ❌        |   |

## 📤 Outputs

| Output Name    | Description                                    |   |
| -------------- | ---------------------------------------------- | - |
| `public_ip_id` | The ID(s) of the created Public IP address(es) |   |

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`

## 🛡️ Best Practices

* Use `Static` allocation for resources that require a fixed IP address.
* Opt for `Standard` SKU for production workloads to benefit from enhanced features and security.
* Assign meaningful tags to resources for better management and cost tracking.

## 📄 License

This module is maintained by the DHDP CloudOps team. Contributions and feedback are welcome.
