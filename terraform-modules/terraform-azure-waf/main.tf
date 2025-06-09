resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  policy_settings {
    enabled                     = true
    mode                        = var.mode
    request_body_check          = true
    file_upload_limit_in_mb     = var.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.max_request_body_size_in_kb
  }

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type

      match_conditions {
        match_variables {
          variable_name = "RemoteAddr"
        }
        operator     = "IPMatch"
        match_values = custom_rules.value.match_values
      }

      action = custom_rules.value.action
    }
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = var.owasp_version
    }
  }

  tags = var.tags
}
