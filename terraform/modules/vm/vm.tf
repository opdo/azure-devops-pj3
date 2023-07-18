resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC56hcnrlDW2ZKnT/VRpkOHh2G8mhwgs2a7DHxrK/1ayXRBszmEXRLMCpPisy8ITlUXZwaipj/Irltd2ivyZwVIzaq0eycr8J3DGk/Y1Y+vUH7ULgLF4uD3gP/uNl2WBsnzezC8/s0ShpDRBXlr0vrxhSouoag6ZL62V8IXskNasqQbFMwIxbxafP+14HlD9OlTo3/ymrffT24BGz+tJEq9xRbe6iYxDBy9Zv9ClNLWkRnxnxBn9xrz/YA1Zqub35+Q2/9Y4JhRIYFNTshDia+TbVVKxHjxkGn0PwD6pDrK3gW3j1WqexehmgKiQVtqRF4z+9n9mx8zEvHwbvSUQxP6jDe8YSf+oetoMZZXC0uV07cTRUxWs+SCzn262VDsNViXb8KatUxjIB2v2OClKN96VSXNNrQV96Fdw1Qp7MQlDZN58291i2HVOQioIhbjL8Xt4odgOhv2qRKXbHQnTDd/QP9fgidkYkB5iDJuAPlo3+RvvdA0V5fc0qVguaDprs0= devopsagent@myLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
