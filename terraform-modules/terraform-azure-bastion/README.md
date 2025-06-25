# Azure Bastion Host Terraform Module

This Terraform module provisions an **Azure Bastion Host**, which provides secure and seamless RDP/SSH access to your virtual machines over SSL without exposing them to public IPs.

## 📁 Module Contents

- `main.tf` – Declares the Bastion Host resource.
- `variables.tf` – Defines the required input variables.
- `output.tf` – Outputs the Bastion Host ID.
- `versions.tf` – Specifies provider and Terraform version constraints.

---

## 🚀 Usage

```hcl
module "bastion" {
  source              = "../terraform_modules/azure-bastion"
  
  name                = "dhdp-bastion"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  subnet_id           = azurerm_subnet.bastion_subnet.id
  public_ip_id        = azurerm_public_ip.bastion_public_ip.id
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

---

## 📥 Input Variables

| Variable              | Description                                                 | Type          | Required         |
| --------------------- | ----------------------------------------------------------- | ------------- | ---------------- |
| `name`                | Name of the Bastion Host                                    | `string`      | ✅                |
| `location`            | Azure region                                                | `string`      | ✅                |
| `resource_group_name` | Name of the resource group                                  | `string`      | ✅                |
| `subnet_id`           | Subnet ID for the Bastion Host (must be AzureBastionSubnet) | `string`      | ✅                |
| `public_ip_id`        | Public IP resource ID to associate with Bastion             | `string`      | ✅                |
| `tags`                | Optional tags to apply to the Bastion Host                  | `map(string)` | ❌ (default `{}`) |

---

## 📤 Output

| Output Name  | Description                |
| ------------ | -------------------------- |
| `bastion_id` | The ID of the Bastion Host |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Subnet must be named `AzureBastionSubnet`

---

## 🛡️ Security Best Practices

* Always deploy Bastion in a dedicated subnet named `AzureBastionSubnet`.
* Lock down access via NSGs and Role-Based Access Control (RBAC).
* Do not assign public IPs directly to virtual machines.

---

## 📄 License

This module is maintained by the CloudOps Team. Contributions welcome!


