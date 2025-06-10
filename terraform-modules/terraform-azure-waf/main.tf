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

  # ── Block Log4Shell (CVE-2021-44228) Lookups ─────────────────────────────
  custom_rules {
    name      = "block-log4shell"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "RequestBody"
      }
      operator     = "Contains"
      match_values = ["\${jndi:"]
      transforms   = ["Lowercase"]
    }
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

  # ── Microsoft Bot Manager ─────────────────────────────────────────────────
  managed_rules {
    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.0"
    }
  }

  tags = var.tags
}
