# Azure NAT Gateway Terraform Module

This Terraform module provisions an **Azure NAT Gateway** with a public IP association and binds it to a subnet. This setup allows outbound internet access for resources in private subnets while preserving security and control.

---

## 📁 Module Structure

- `main.tf` – Provisions NAT Gateway and associates it with a public IP and subnet.
- `variables.tf` – Input variables for customization.
- `output.tf` – Outputs the NAT Gateway ID.
- `versions.tf` – Specifies required versions for Terraform and providers.

---

## 🚀 Usage

```hcl
module "nat_gateway" {
  source = "../terraform_modules/azure-nat-gateway"

  name                = "dhdp-nat-gateway"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  public_ip_id        = azurerm_public_ip.nat.id
  subnet_id           = azurerm_subnet.private_subnet.id

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

Replace `source` with the correct relative path to this module in your repo.

---

## 📥 Input Variables

| Name                  | Description                                                 | Type          | Default      | Required |
| --------------------- | ----------------------------------------------------------- | ------------- | ------------ | -------- |
| `name`                | Name of the NAT Gateway                                     | `string`      | —            | ✅        |
| `location`            | Azure region                                                | `string`      | —            | ✅        |
| `resource_group_name` | Name of the resource group                                  | `string`      | —            | ✅        |
| `sku_name`            | NAT Gateway SKU (`Standard` is the only valid option)       | `string`      | `"Standard"` | ❌        |
| `public_ip_id`        | Resource ID of the associated public IP address             | `string`      | —            | ✅        |
| `subnet_id`           | Resource ID of the subnet to associate with the NAT Gateway | `string`      | —            | ✅        |
| `tags`                | Tags to apply to the NAT Gateway                            | `map(string)` | `{}`         | ❌        |

---

## 📤 Outputs

| Output Name      | Description           |
| ---------------- | --------------------- |
| `nat_gateway_id` | ID of the NAT Gateway |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* A public IP address and target subnet must exist prior to applying this module

---

## 🛡️ Best Practices

* Use NAT Gateway for outbound internet traffic in private subnets instead of public IPs on VMs.
* Combine with NSGs and route tables for fine-grained traffic control.
* Use tagging for cost management and environment tracking.

---

## 📄 License

Maintained by the DHDP CloudOps team. Contributions welcome.
