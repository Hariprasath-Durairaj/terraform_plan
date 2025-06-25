###############################################################################
# variables.tf – Require-Enterprise-Tags module
###############################################################################

variable "policy_name" {
  description = "Name for the custom Azure Policy Definition."
  type        = string
}

variable "policy_display_name" {
  description = "Display name shown in the Azure portal."
  type        = string
}

variable "policy_description" {
  description = "Detailed description of the policy’s purpose."
  type        = string
}

variable "required_tags" {
  description = "List of tag keys that must exist on every resource."
  type        = list(string)

  # Default to the 7-key enterprise standard; callers may override.
  default = [
    "environment",
    "businessUnit",
    "application",
    "owner",
    "managedBy",
    "createdBy",
    "criticality",
  ]
}

variable "policy_assignment_scope" {
  description = "Scope at which the policy will be assigned (subscription, management-group, or resource-group ID)."
  type        = string
}

variable "policy_assignment_name" {
  description = "Name for the Policy Assignment."
  type        = string
}

variable "tags" {
  description = <<DESC
Map of default tag **values** used when the policy auto-appends missing tags
*and* applied to the Policy resources themselves.  
Keys should match the required_tags list.
DESC
  type = map(string)

  # Example defaults; override in the module call.
  default = {
    environment  = "QA"
    businessUnit = "Corp-IT"
    application  = "Bitnobi"
    owner        = "hari@corp.com"
    managedBy    = "SRE-Team"
    createdBy    = "Terraform"
    criticality  = "Standard"
  }
}
