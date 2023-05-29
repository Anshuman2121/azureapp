data "azurerm_virtual_network" "windowsvmvm" {
  name = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "windowsvmvm" {
  name      = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.windowsvmvm.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "windowsvmvm" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windowsvmvm.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windowsvmvm" {
  name                = "windowsvmvm-machine"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.windowsvmvm.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}