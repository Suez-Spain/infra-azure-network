provider "azurerm" {
  version = "=2.50.0"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "tbackend"
    resource_group_name  = "SUEZSpain-RG-INFRA-DEVOPS"
    container_name       = "tstate"
    key                  = "NETWORKING/DEV/subnets/testjavi/terraform.tfstate"
  }
}