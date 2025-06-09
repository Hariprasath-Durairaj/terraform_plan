###############################################################################
# versions.tf – QA Environment                                               #
###############################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100" # stick to current major for stability
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22" # matches AKS 1.29+ API versions
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "azurerm" {
  features {}
}
