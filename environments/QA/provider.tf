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
      version = "~> 2.12" # supports AGIC Helm install
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0" # for Azure AD resources
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # for unique ID generation
    }
  }
}

provider "azurerm" {
  features {}
}
