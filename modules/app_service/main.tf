resource "azurerm_app_service_plan" "app_service" {
  name                = var.azurerm_app_service_plan
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_plan_id
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service.id

  site_config {
    always_on                 = true
    dotnet_framework_version    = "v4.0"
    use_32_bit_worker_process = true
    windows_fx_version        = "Windows_Server_Core_v2019"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

#   connection_string {
#     name  = "Database"
#     type  = "SQLServer"
#     value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
#   }
}