data "azurerm_virtual_network" "linuxvm" {
  name = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "linuxvm" {
  name      = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.linuxvm.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "linuxvm" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.linuxvm.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.linuxvm.id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}