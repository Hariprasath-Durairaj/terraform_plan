# Azure Application Gateway Terraform Module

This Terraform module provisions an Azure Application Gateway with support for:

- Public or private frontend IP configuration
- HTTP and HTTPS listeners
- Custom and managed WAF rules
- Backend pools and HTTP settings
- Health probes
- Routing rules

---

## Usage Example

```hcl
module "app_gateway" {
  source              = "../terraform-azure-appgateway"
  name                = "dhdp-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name     = "WAF_v2"
  tier         = "WAF_v2"
  waf_enabled  = true
  waf_mode     = "Prevention"

  frontend_ip_configuration = {
    public_ip_id = azurerm_public_ip.this.id
  }

  backend_address_pools = [
    {
      name  = "backend1"
      fqdns = ["app1.internal.cloud"]
    }
  ]

  backend_http_settings = [
    {
      name                  = "http-setting1"
      port                  = 80
      protocol              = "Http"
      cookie_based_affinity = "Disabled"
      request_timeout       = 20
    }
  ]

  http_listeners = [
    {
      name                           = "http-listener"
      frontend_ip_configuration_name = "public"
      frontend_port_name             = "port-80"
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = "rule1"
      rule_type                  = "Basic"
      http_listener_name         = "http-listener"
      backend_address_pool_name  = "backend1"
      backend_http_settings_name = "http-setting1"
    }
  ]

  probes = [
    {
      name                = "health-probe"
      protocol            = "Http"
      path                = "/health"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3
      pick_host_name_from_backend_http_settings = true
      match = {
        status_codes = ["200-399"]
      }
    }
  ]

  tags = {
    Environment = "QA"
    Project     = "DHDP"
  }
}
````

---

## Inputs

| Name                        | Type           | Default        | Description                                   |
| --------------------------- | -------------- | -------------- | --------------------------------------------- |
| `name`                      | `string`       | —              | Name of the Application Gateway               |
| `location`                  | `string`       | —              | Azure region                                  |
| `resource_group_name`       | `string`       | —              | Resource group name                           |
| `sku_name`                  | `string`       | `"WAF_v2"`     | SKU name of the App Gateway                   |
| `tier`                      | `string`       | `"WAF_v2"`     | Tier of the App Gateway                       |
| `waf_enabled`               | `bool`         | `true`         | Enable Web Application Firewall               |
| `waf_mode`                  | `string`       | `"Prevention"` | WAF mode: `Detection` or `Prevention`         |
| `frontend_ip_configuration` | `map(any)`     | —              | Map with either `public_ip_id` or `subnet_id` |
| `backend_address_pools`     | `list(object)` | `[]`           | List of backend address pool definitions      |
| `backend_http_settings`     | `list(object)` | `[]`           | List of HTTP settings for backends            |
| `http_listeners`            | `list(object)` | `[]`           | HTTP/HTTPS listener definitions               |
| `request_routing_rules`     | `list(object)` | `[]`           | List of routing rules                         |
| `probes`                    | `list(object)` | `[]`           | Health probe definitions                      |
| `tags`                      | `map(string)`  | `{}`           | Tags to apply to the resource                 |

---

## Outputs

| Name          | Description                         |
| ------------- | ----------------------------------- |
| `appgw_id`    | The ID of the Application Gateway   |
| `appgw_name`  | The name of the Application Gateway |
| `frontend_ip` | The frontend IP address             |

---

## Notes

* Either `public_ip_id` or `subnet_id` must be provided in `frontend_ip_configuration`.
* Health probes are optional but recommended for production environments.
* WAF rules can be extended using `custom_rules` or `managed_rules` in future versions.


