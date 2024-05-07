data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_network_interface" "node" {
  count = var.node_count
  name                = "${var.node_type}-nic-${count.index}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration_${var.node_type}-${count.index}"
    subnet_id                     = var.main_subnet_id[count.index]
    private_ip_address_allocation = "Dynamic"
  }

  
}

resource "azurerm_network_security_group" "main_security_group" {
  name                = "${var.node_type}_security"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_virtual_machine" "main" {
  count                 = var.node_count  
  name                  = "${var.name_prefix}_${var.node_type}-${count.index}"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.node[*].id, count.index)]
  vm_size               = var.machine_size
  delete_os_disk_on_termination = false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.node_type}-${count.index}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.storage_size_gb
  }

  os_profile {
    computer_name  = "${var.node_type}-${count.index}"
    admin_username = "adminuser"
    admin_password = "YourPassword1234!" # Will use secrets
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}
