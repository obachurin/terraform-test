terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.25.0"
    }
  }

  #overwrite from cli, see configs in config folder
  backend "azurerm" {
  }

}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
