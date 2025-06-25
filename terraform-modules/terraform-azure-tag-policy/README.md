# Azure Tag Policy Terraform Module

This Terraform module creates **Azure Policy Definitions and their assignments** to enforce a consistent tagging standard across your Azure estate.  Ensuring that every resource carries the mandatory tags improves governance, FinOps charge‑back, and operational ownership.

---

## 📁 Module Structure

| File               | Purpose                                      |
| ------------------ | -------------------------------------------- |
| **`main.tf`**      | Builds the Policy Definition & Assignment    |
| **`variables.tf`** | Declares all configurable inputs             |
| **`outputs.tf`**   | Exposes IDs for the created policy resources |
| **`versions.tf`**  | Locks Terraform & provider versions          |

---

## 🚀 Usage

```hcl
module "tag_policy" {
  source = "../terraform_modules/terraform-azure-tag-policy"

  ### Policy configuration
  policy_name         = "require-enterprise-tags"
  policy_display_name = "Enforce Enterprise Tags on All Resources"
  policy_description  = "Ensures that every resource is stamped with the mandatory enterprise tag set."

  # Mandatory tag keys
  required_tags = [
    "environment",
    "businessUnit",
    "application",
    "owner",
    "managedBy",
    "createdBy",
    "criticality"
  ]

  ### Assignment configuration
  policy_assignment_scope = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  policy_assignment_name  = "require-enterprise-tags-assignment"

  ### Optional metadata tags applied to the policy itself
  tags = {
    environment  = "QA"
    businessUnit = "Corp-IT"
    application  = "Platform-Governance"
    owner        = "platform-team@corp.com"
    managedBy    = "Terraform"
    createdBy    = "AzureDevOps"
    criticality  = "Standard"
  }
}
```

> **Replace** the `source` path and the `policy_assignment_scope` with values for your environment.

---

## 📥 Input Variables

| Name                      | Description                                                | Type           | Default | Required |
| ------------------------- | ---------------------------------------------------------- | -------------- | ------- | -------- |
| `policy_name`             | Name for the Azure Policy Definition                       | `string`       | n/a     | ✅        |
| `policy_display_name`     | Human‑readable display name                                | `string`       | n/a     | ✅        |
| `policy_description`      | Detailed description of the policy intent                  | `string`       | n/a     | ✅        |
| `required_tags`           | **List of tag keys** that every resource must include      | `list(string)` | n/a     | ✅        |
| `policy_assignment_scope` | Scope for assignment (subscription, RG, or MG path)        | `string`       | n/a     | ✅        |
| `policy_assignment_name`  | Name for the Policy Assignment                             | `string`       | n/a     | ✅        |
| `tags`                    | Map of tags applied **to the policy resources themselves** | `map(string)`  | `{}`    | ❌        |

---

## 📤 Outputs

| Output Name            | Description                          |
| ---------------------- | ------------------------------------ |
| `policy_definition_id` | Resource ID of the Policy Definition |
| `policy_assignment_id` | Resource ID of the Policy Assignment |

---

## ✅ Requirements

* **Terraform** `>= 1.3.0`
* **AzureRM provider** `~> 3.100`

---

## 🛡️ Best Practices

1. Adopt a **single enterprise tag schema** (the seven keys above) and publish it internally.
2. Use **Azure Policy** in *deny* mode for production subscriptions; start with *audit* in dev.
3. Combine this module with cost‑management reports and Azure Lighthouse for full FinOps transparency.

---

## 📄 License

Maintained by the **DHDP CloudOps** team.  Contributions & feedback welcome under the project’s CONTRIBUTING guidelines.
