terraform {
  backend "azurerm" {
    resource_group_name  = "dhdp-qa-resource-group"
    storage_account_name = "dhdpqa"
    container_name       = "qatfstate"
    key                  = "qa/terraform.tfstate"
  }
}
