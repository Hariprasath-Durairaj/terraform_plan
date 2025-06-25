###############################################################################
#  main.tf  –  Azure Policy: Require Enterprise Tags                         #
###############################################################################

########## Policy Definition ##################################################
resource "azurerm_policy_definition" "require_enterprise_tags" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = var.policy_display_name
  description  = var.policy_description

  # Category shown in the Azure portal
  metadata = jsonencode({ category = "Tags" })

  # --- Parameters: one for each mandatory tag -------------------------------
  parameters = jsonencode({
    environment  = { type = "String"; metadata = { displayName = "environment"  } }
    businessUnit = { type = "String"; metadata = { displayName = "businessUnit" } }
    application  = { type = "String"; metadata = { displayName = "application"  } }
    owner        = { type = "String"; metadata = { displayName = "owner"        } }
    managedBy    = { type = "String"; metadata = { displayName = "managedBy"    } }
    createdBy    = { type = "String"; metadata = { displayName = "createdBy"    } }
    criticality  = { type = "String"; metadata = { displayName = "criticality"  } }
  })

  # --- Policy rule: append any missing tag -----------------------------------
  policy_rule = <<POLICY_RULE
{
  "if": {
    "anyOf": [
      { "field": "tags['environment']",  "exists": "false" },
      { "field": "tags['businessUnit']", "exists": "false" },
      { "field": "tags['application']",  "exists": "false" },
      { "field": "tags['owner']",        "exists": "false" },
      { "field": "tags['managedBy']",    "exists": "false" },
      { "field": "tags['createdBy']",    "exists": "false" },
      { "field": "tags['criticality']",  "exists": "false" }
    ]
  },
  "then": {
    "effect": "modify",
    "details": {
      "roleDefinitionIds": [
        "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"   // Contributor
      ],
      "operations": [
        { "operation": "add", "field": "tags['environment']",  "value": "[parameters('environment')]"  },
        { "operation": "add", "field": "tags['businessUnit']", "value": "[parameters('businessUnit')]" },
        { "operation": "add", "field": "tags['application']",  "value": "[parameters('application')]"  },
        { "operation": "add", "field": "tags['owner']",        "value": "[parameters('owner')]"        },
        { "operation": "add", "field": "tags['managedBy']",    "value": "[parameters('managedBy')]"    },
        { "operation": "add", "field": "tags['createdBy']",    "value": "[parameters('createdBy')]"    },
        { "operation": "add", "field": "tags['criticality']",  "value": "[parameters('criticality')]"  }
      ]
    }
  }
}
POLICY_RULE
}

########## Policy Assignment ##################################################
resource "azurerm_policy_assignment" "require_enterprise_tags" {
  name                 = var.policy_assignment_name
  scope                = var.policy_assignment_scope
  policy_definition_id = azurerm_policy_definition.require_enterprise_tags.id

  # Default values for each tag (taken from the map you pass via module input)
  parameters = jsonencode({
    environment  = { value = lookup(var.tags, "environment",  "") }
    businessUnit = { value = lookup(var.tags, "businessUnit", "") }
    application  = { value = lookup(var.tags, "application",  "") }
    owner        = { value = lookup(var.tags, "owner",        "") }
    managedBy    = { value = lookup(var.tags, "managedBy",    "") }
    createdBy    = { value = lookup(var.tags, "createdBy",    "") }
    criticality  = { value = lookup(var.tags, "criticality",  "") }
  })

  # Optional metadata or audit tags on the assignment resource itself
  tags = var.tags
}
