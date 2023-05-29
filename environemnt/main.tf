module "linuxvm" {
    source = "../modules/linux_vm"
    virtual_network_name = "vnet-loadbalancer-demo"
    subnet_name = "default"
    resource_group_name = "rg-loadbalancer-demo"
    location = "eastus"
    vm_name = "raju-linuxvm"
}

module "windowsvmvm" {
    source = "../modules/windows_vm"
    virtual_network_name = "vnet-loadbalancer-demo"
    subnet_name = "default"
    resource_group_name = "rg-loadbalancer-demo"
    location = "eastus"
    vm_name = "raju-linuxvm"
}

module "functionapp" {
  source = "../modules/function_app"
  storage_account_name = "rajufuncapp"
    resource_group_name = "rg-loadbalancer-demo"
    location = "eastus"
    azurerm_app_service_plan = "rajuappserviceplan"
    FunctionApp_name = "rajufunctionapp"
    app_service_plan_id = "rajuappserviceplan"
}

module "application_insights" {
  source = "../modules/application_insights"
  azurerm_application_insights_name = "rajuappinsights"
  resource_group_name = "rg-loadbalancer-demo"
  location = "eastus"
}

module "app_service" {
  source = "../modules/app_service"
  resource_group_name = "rg-loadbalancer-demo"
  location = "eastus"
  azurerm_app_service_plan = "rajuappserviceplan"
  app_service_plan_id = "rajuappserviceplan"
}
  
module "app_service" {
  source = "../modules/app_service"
  resource_group_name = "rg-loadbalancer-demo"
  location = "eastus"
  azurerm_app_service_plan = "rajuappserviceplan"
  app_service_plan_id = "rajuappserviceplan"
}