terraform {
  backend "azurerm" {
    resource_group_name  = "dhdp-qat-resource-group"
    storage_account_name = "dhdplabsa"
    container_name       = "tfstate"
    key                  = "qa/terraform.tfstate"
  }
}
