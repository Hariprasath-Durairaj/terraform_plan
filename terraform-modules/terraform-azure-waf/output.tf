output "waf_policy_id" {
  description = "The ID of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.id
}

output "waf_policy_resource_id" {
  value       = azurerm_web_application_firewall_policy.this.id
  description = "The resource ID of the WAF policy"
}

output "waf_policy_name" {
  description = "The name of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.name
}
