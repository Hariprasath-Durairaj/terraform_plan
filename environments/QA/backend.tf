terraform {
  backend "azurerm" {
    resource_group_name  = "dhdp-qa-rg"
    storage_account_name = "dhdpqasf"
    container_name       = "qatfstate"
    key                  = "qa/terraform.tfstate"
  }
}
