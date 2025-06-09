output "policy_definition_id" {
  description = "Resource ID of the Enterprise-Tag Policy Definition"
  value       = azurerm_policy_definition.require_enterprise_tags.id
}

output "policy_assignment_id" {
  description = "Resource ID of the Enterprise-Tag Policy Assignment"
  value       = azurerm_policy_assignment.require_enterprise_tags.id
}
