# Azure Web Application Firewall (WAF) Terraform Module

This Terraform module provisions an Azure Web Application Firewall (WAF) policy, enabling protection for web applications against common threats and vulnerabilities. It supports both managed and custom rules, allowing for flexible and granular security configurations.

## 📁 Module Structure

* `main.tf` – Defines the `azurerm_web_application_firewall_policy` resource with customizable settings.
* `variables.tf` – Declares input variables for configuring the WAF policy.
* `output.tf` – Outputs relevant resource identifiers.
* `versions.tf` – Specifies required Terraform and provider versions.

## 🚀 Usage

```hcl
module "waf_policy" {
  source = "../terraform_modules/terraform-azure-waf"

  name                = "example-waf-policy"
  resource_group_name = "example-rg"
  location            = "Canada Central"
  mode                = "Prevention"
  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
```



Replace `source` with the correct relative path to this module in your project.

## 📥 Input Variables

| Name                  | Description                                         | Type           | Default        | Required |   |
| --------------------- | --------------------------------------------------- | -------------- | -------------- | -------- | - |
| `name`                | Name of the WAF policy                              | `string`       | n/a            | ✅        |   |
| `resource_group_name` | Name of the resource group                          | `string`       | n/a            | ✅        |   |
| `location`            | Azure region where the WAF policy will be created   | `string`       | n/a            | ✅        |   |
| `mode`                | Mode of the WAF policy: `Prevention` or `Detection` | `string`       | `"Prevention"` | ❌        |   |
| `custom_rules`        | List of custom rules to apply to the WAF policy     | `list(object)` | `[]`           | ❌        |   |
| `managed_rules`       | List of managed rule sets to apply                  | `list(object)` | `[]`           | ❌        |   |
| `tags`                | Tags to apply to the WAF policy                     | `map(string)`  | `{}`           | ❌        |   |

## 📤 Outputs

| Output Name       | Description                        |   |
| ----------------- | ---------------------------------- | - |
| `waf_policy_id`   | The ID of the created WAF policy   |   |
| `waf_policy_name` | The name of the created WAF policy |   |

## ✅ Requirements

* Terraform `>= 1.3.0`
* AzureRM Provider `~> 3.100`

## 🛡️ Best Practices

* Use `Prevention` mode for production environments to actively block malicious requests.
* Regularly update managed rule sets to incorporate the latest threat protections.
* Define custom rules to address application-specific security requirements.
* Monitor WAF logs to analyze and respond to potential threats.

## 📄 License

This module is maintained by the DHDP CloudOps team. Contributions and feedback are welcome.
