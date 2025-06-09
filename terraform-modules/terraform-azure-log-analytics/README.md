# Azure Log Analytics Workspace Terraform Module

This module provisions an **Azure Log Analytics Workspace**, used for collecting and analyzing log data from resources across your Azure environment.

---

## 📁 Module Structure

- `main.tf` – Provisions the `azurerm_log_analytics_workspace` resource.
- `variables.tf` – Defines configurable input variables like SKU, retention, and tags.
- `output.tf` – Exports the workspace ID and name.
- `versions.tf` – Specifies required versions for Terraform and AzureRM provider.

---

## 🚀 Usage Example

```hcl
module "log_analytics" {
  source = "../terraform_modules/azure-log-analytics"

  name                = "dhdp-log-workspace"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Update the `source` path to match your module location.

---

## 📥 Input Variables

| Name                  | Description                                      | Type          | Default     | Required |
| --------------------- | ------------------------------------------------ | ------------- | ----------- | -------- |
| `name`                | Name of the Log Analytics workspace              | `string`      | —           | ✅        |
| `location`            | Azure region                                     | `string`      | —           | ✅        |
| `resource_group_name` | Resource group name                              | `string`      | —           | ✅        |
| `sku`                 | SKU of the workspace (`PerGB2018`, `Free`, etc.) | `string`      | `PerGB2018` | ❌        |
| `retention_in_days`   | Number of days to retain logs                    | `number`      | `30`        | ❌        |
| `tags`                | Tags to assign to the workspace                  | `map(string)` | `{}`        | ❌        |

---

## 📤 Outputs

| Output Name      | Description                             |
| ---------------- | --------------------------------------- |
| `workspace_id`   | The ID of the Log Analytics workspace   |
| `workspace_name` | The name of the Log Analytics workspace |

---

## ✅ Prerequisites

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Azure subscription with access to create monitoring resources

---

## 🛡️ Best Practices

* Connect this workspace to Azure Monitor, Application Insights, and AKS clusters.
* Retain logs for compliance and troubleshooting, adjust `retention_in_days` as needed.
* Tag resources for cost tracking and lifecycle management.

---

## 📄 License

Maintained by the DHDP CloudOps team. Feel free to contribute or raise issues.

