# Azure Key Vault Terraform Module

This Terraform module provisions an Azure Key Vault with advanced configuration options including RBAC, soft delete retention, purge protection, and network access control.

---

## 📁 Module Files

- `main.tf` – Defines the `azurerm_key_vault` resource.
- `variables.tf` – Declares all configurable variables.
- `output.tf` – Outputs the Key Vault ID, name, and URI.
- `versions.tf` – Specifies required Terraform and provider versions.

---

## 🚀 Usage

```hcl
module "key_vault" {
  source = "../terraform_modules/azure-key-vault"

  name                        = "dhdp-keyvault"
  location                    = "Canada Central"
  resource_group_name         = "dhdp-lab-resource-group"
  tenant_id                   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  enable_rbac_authorization   = true
  enabled_for_deployment      = false
  enabled_for_disk_encryption = true
  enabled_for_template_deployment = false
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  default_action              = "Deny"
  bypass                      = "AzureServices"
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Replace the `source` path with the correct relative path in your project.

---

## 📥 Input Variables

| Name                              | Description                                             | Type          | Default           | Required |
| --------------------------------- | ------------------------------------------------------- | ------------- | ----------------- | -------- |
| `name`                            | Name of the Key Vault                                   | `string`      | —                 | ✅        |
| `location`                        | Azure region                                            | `string`      | —                 | ✅        |
| `resource_group_name`             | Name of the resource group                              | `string`      | —                 | ✅        |
| `tenant_id`                       | Azure Active Directory Tenant ID                        | `string`      | —                 | ✅        |
| `enable_rbac_authorization`       | Enable RBAC authorization                               | `bool`        | `true`            | ❌        |
| `enabled_for_deployment`          | Allow Azure deployments to access the Key Vault         | `bool`        | `false`           | ❌        |
| `enabled_for_disk_encryption`     | Allow access for disk encryption                        | `bool`        | `true`            | ❌        |
| `enabled_for_template_deployment` | Allow template deployments                              | `bool`        | `false`           | ❌        |
| `purge_protection_enabled`        | Enables purge protection                                | `bool`        | `true`            | ❌        |
| `soft_delete_retention_days`      | Retention days for soft-deleted items                   | `number`      | `7`               | ❌        |
| `default_action`                  | Default action for network ACLs (`Allow` or `Deny`)     | `string`      | `"Deny"`          | ❌        |
| `bypass`                          | Services allowed to bypass ACLs (e.g., `AzureServices`) | `string`      | `"AzureServices"` | ❌        |
| `tags`                            | Tags to apply                                           | `map(string)` | `{}`              | ❌        |

---

## 📤 Outputs

| Output Name      | Description                                    |
| ---------------- | ---------------------------------------------- |
| `key_vault_id`   | ID of the Key Vault                            |
| `key_vault_name` | Name of the Key Vault                          |
| `key_vault_uri`  | URI endpoint for accessing secrets, keys, etc. |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Ensure Key Vault subnet access is properly configured if used with private endpoints

---

## 🔐 Security Recommendations

* Use RBAC over traditional access policies where possible.
* Enable purge protection and soft delete for compliance.
* Apply NSG or firewall rules using private endpoints when possible.

---

## 📄 License

Maintained by the DHDP CloudOps team. Community contributions are welcome.
