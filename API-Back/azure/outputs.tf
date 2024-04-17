# Exibir IP Linux
output "public_ip_address_Linux" {
  value = azurerm_public_ip.public_ip_linux.ip_address
}

# Exibir IP Windows
output "public_ip_address_Windows" {
  value = azurerm_public_ip.public_ip_windows.ip_address
}

# Exibir Usuário Linux
output "Usuario_Linux" {
  value = azurerm_linux_virtual_machine.linux.admin_username
}

# Exibir Senha Linux
output "Senha_Linux" {
  value     = azurerm_linux_virtual_machine.linux.admin_password
  sensitive = true
}

# Exibir Usuário Windows
output "Usuario_Windows" {
  value = azurerm_windows_virtual_machine.windows.admin_username
}

# Exibir Senha Windows
output "Senha_Windows" {
  value     = azurerm_windows_virtual_machine.windows.admin_password
  sensitive = true
}