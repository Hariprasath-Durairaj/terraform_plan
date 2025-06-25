# Azure Recovery Services Vault Terraform Module

This Terraform module creates an Azure Recovery Services Vault, which is used to back up and restore Azure resources such as Virtual Machines, File Shares, and more.

---

## 📁 Module Structure

- `main.tf` – Defines the `azurerm_recovery_services_vault` resource.
- `variables.tf` – Declares configurable input variables.
- `output.tf` – Exposes outputs such as the vault ID and name.
- `versions.tf` – Specifies the required Terraform and provider versions.

---

## 🚀 Usage

```hcl
module "recovery_vault" {
  source              = "../terraform_modules/azure-recovery-vault"

  name                = "dhdp-recovery-vault"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  sku                 = "Standard"
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Replace `source` with the correct path to your module.

---

## 📥 Input Variables

| Name                  | Description                                          | Type          | Default      | Required |
| --------------------- | ---------------------------------------------------- | ------------- | ------------ | -------- |
| `name`                | The name of the Recovery Services Vault              | `string`      | —            | ✅        |
| `location`            | The Azure region to deploy the vault                 | `string`      | —            | ✅        |
| `resource_group_name` | Name of the resource group                           | `string`      | —            | ✅        |
| `sku`                 | SKU of the vault (`Standard` or others if supported) | `string`      | `"Standard"` | ❌        |
| `tags`                | Map of tags to apply to the vault                    | `map(string)` | `{}`         | ❌        |

---

## 📤 Outputs

| Output Name  | Description                             |
| ------------ | --------------------------------------- |
| `vault_id`   | The ID of the Recovery Services Vault   |
| `vault_name` | The name of the Recovery Services Vault |

---

## ✅ Prerequisites

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Sufficient IAM permissions to manage Recovery Vaults

---

## 🛡️ Best Practices

* Always assign RBAC roles for vault access securely.
* Enable soft delete and lock protection (if not handled here, consider manually or through another module).
* Use naming conventions to ensure traceability across environments.

---

## 📄 License

This module is maintained by the CloudOps Team. Contributions and improvements are welcome.
