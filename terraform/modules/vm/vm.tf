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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/tZ4H3b/CUdLRR57p/6bNInbwC9OhMUw7DIP3cBlyrbQNQ3rms/IeEadR8lFa4Vmd3CM9ihkJvffGbYLF9hSK1YYGvbJtkOZW7o+5i1kqlP5YoLDfzDtaabtVjv331Crkf99HXLf1qD6HxmfHH7T7Pxu484NMFK8tGOqV/f0r2WNBfGJ19pJIJUSwkfWQsdw+uyfKh22+4qFcpB1yYFMUkBJzOh1Y1vUhcwC/MobF6dh4ImiGuX/CDwj9BGXznF8d0z4nJfFNwgAwlKA9IUswunNNOY2D5pRB+FOqZyVvvhqk5vuzJxs5cJ97fxeo1Cz+dzQmvLN9v3IOtO9KxO0G2cjVTiwOcrKVN1malSrC3z8xjhJ/dJc17aG3l+aJiINLAeAhBzoIge6qclB2TjeLO9uXVlSx4+jBwjJ/TyxjZerEoaiOZLV2/8jSNm9L31QBv2grhPyt3dU4GSYuvRvqytFbj2IOsHwa/3RY28vQnXGiFyfh5rXW9zSGyF7tGFs= devopsagent@myLinuxVM"
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
