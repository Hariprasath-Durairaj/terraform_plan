# Terraform Module: Azure Container Registry (ACR)

This module provisions an Azure Container Registry (ACR) with optional admin access and identity settings.

## Inputs

| Name                          | Type          | Default     | Description                                      |
|-------------------------------|---------------|-------------|--------------------------------------------------|
| `name`                        | `string`      | n/a         | Name of the ACR.                                 |
| `resource_group_name`         | `string`      | n/a         | Resource group name.                             |
| `location`                    | `string`      | n/a         | Azure region.                                    |
| `sku`                         | `string`      | `"Standard"`| SKU of the ACR: Basic, Standard, Premium.        |
| `admin_enabled`               | `bool`        | `false`     | Enable admin user.                               |
| `public_network_access_enabled`| `bool`      | `false`     | Allow public access to ACR.                      |
| `identity_type`               | `string`      | `"SystemAssigned"` | Type of managed identity.                 |
| `tags`                        | `map(string)` | `{}`        | Tags to apply.                                   |

## Outputs

| Name              | Description                          |
|-------------------|--------------------------------------|
| `acr_id`          | Resource ID of the ACR.              |
| `acr_login_server`| Login server URL of the ACR.         |

## Example Usage

```hcl
module "acr" {
  source = "./modules/acr"

  name                          = "myacrregistry"
  resource_group_name           = "my-rg"
  location                      = "Canada Central"
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = false
  identity_type                 = "SystemAssigned"
  tags = {
    environment = "dev"
    managedby   = "terraform"
  }
}
