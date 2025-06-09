# Azure Disk Encryption Set Terraform Module

This module provisions an Azure Disk Encryption Set (DES) using Terraform. Disk Encryption Sets allow encryption of managed disks with customer-managed keys stored in Azure Key Vault.

---

## 📁 Module Files

- `main.tf` – Declares the `azurerm_disk_encryption_set` resource.
- `variables.tf` – Defines all required and optional inputs.
- `output.tf` – Exports the encryption set's resource ID.
- `versions.tf` – Specifies required Terraform and provider versions.

---

## 🚀 Usage

```hcl
module "disk_encryption_set" {
  source = "../terraform_modules/azure-disk-encryption-set"

  name                = "dhdp-diskencset"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  key_vault_key_id    = azurerm_key_vault_key.example.id

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Update the `source` path according to your project structure.

---

## 📥 Input Variables

| Name                  | Description                                     | Type          | Default | Required |
| --------------------- | ----------------------------------------------- | ------------- | ------- | -------- |
| `name`                | Name of the Disk Encryption Set                 | `string`      | —       | ✅        |
| `location`            | Azure region where the DES will be created      | `string`      | —       | ✅        |
| `resource_group_name` | Name of the Azure resource group                | `string`      | —       | ✅        |
| `key_vault_key_id`    | The ID of the customer-managed key in Key Vault | `string`      | —       | ✅        |
| `tags`                | Tags to assign to the Disk Encryption Set       | `map(string)` | `{}`    | ❌        |

---

## 📤 Outputs

| Output Name              | Description                       |
| ------------------------ | --------------------------------- |
| `disk_encryption_set_id` | The ID of the Disk Encryption Set |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Key Vault key must have proper permissions and be enabled for disk encryption

---

## 🔐 Security Considerations

* Ensure the Key Vault key is protected using access policies or RBAC.
* Use soft-delete and purge protection on Key Vault for enhanced safety.
* Attach the DES to your managed disks using the `disk_encryption_set_id`.

---

## 📄 License

Maintained by the DHDP CloudOps team. PRs and feedback are welcome!
