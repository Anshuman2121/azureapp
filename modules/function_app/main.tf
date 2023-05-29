resource "azurerm_storage_account" "functionapp" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "functionapp" {
  name                = var.app_service_plan_id
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "functionapp" {
  name                       = var.FunctionApp_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.functionapp.id
  storage_account_name       = azurerm_storage_account.functionapp.name
  storage_account_access_key = azurerm_storage_account.functionapp.primary_access_key

    app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "dotnet"
    FUNCTIONS_WORKER_RUNTIME_VERSION = "v4.0"
    OS                         = "Windows"
  }

  version = "~3"
}