# Azure Network Security Group (NSG) Terraform Module

This Terraform module provisions an **Azure Network Security Group (NSG)** and optionally associates it with a subnet. It supports dynamic creation of security rules based on user-defined input.

---

## 📁 Module Files

- `main.tf` – Creates the NSG and its subnet association.
- `variables.tf` – Defines customizable input parameters for NSG, rules, and subnet.
- `output.tf` – Exports the NSG resource ID.
- `versions.tf` – Specifies required Terraform and provider versions.

---

## 🚀 Usage

```hcl
module "nsg" {
  source = "../terraform_modules/azure-nsg"

  nsg_name            = "dhdp-nsg"
  location            = "Canada Central"
  resource_group_name = "dhdp-lab-resource-group"
  subnet_id           = azurerm_subnet.private_subnet.id

  nsg_security_rules = [
    {
      name                       = "Allow-HTTPS"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-All"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
````

---

## 📥 Input Variables

| Name                  | Description                                   | Type           | Default | Required |
| --------------------- | --------------------------------------------- | -------------- | ------- | -------- |
| `location`            | Azure region where the NSG is created         | `string`       | —       | ✅        |
| `resource_group_name` | Name of the resource group                    | `string`       | —       | ✅        |
| `nsg_name`            | Name of the Network Security Group            | `string`       | —       | ✅        |
| `nsg_security_rules`  | List of NSG security rules (inbound/outbound) | `list(object)` | —       | ✅        |
| `tags`                | Optional tags to assign to the NSG            | `map(string)`  | `{}`    | ❌        |
| `subnet_id`           | ID of subnet to associate with NSG (optional) | `string`       | `null`  | ❌        |

---

## 📤 Outputs

| Output Name | Description                              |
| ----------- | ---------------------------------------- |
| `nsg_id`    | ID of the created Network Security Group |

---

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`
* Subnet must already exist if `subnet_id` is provided

---

## 💡 Notes

* Security rules must be well-defined with unique priorities.
* Subnet association is optional; NSG can also be associated with NICs or left standalone.
* Supports flexible rule definitions for custom network topologies.

---

## 📄 License

Maintained by the DHDP CloudOps team. Contributions are welcome.
