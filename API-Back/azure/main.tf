provider "azurerm" {
  features {}
}

# Criar Grupo de Recursos
resource "azurerm_resource_group" "Grupo_de_recursos" {
  name     = "LaisPamela"
  location = "East US"
}

# Criar Conta de Armazenamento
resource "azurerm_storage_account" "Conta_de_armazenamento" {
  name                     = "apilaisrodando"
  resource_group_name      = azurerm_resource_group.Grupo_de_recursos.name
  location                 = azurerm_resource_group.Grupo_de_recursos.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Criar VNET
resource "azurerm_virtual_network" "VNET" {
  name                = "VNET_Azure"
  address_space       = ["172.16.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.Grupo_de_recursos.name
}

# Criar Subrede Pública
resource "azurerm_subnet" "Subrede_Publica" {
  name                 = "SubredePub"
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.Grupo_de_recursos.name
  address_prefixes     = ["172.16.1.0/24"]

}

# Criar Subrede Privada
resource "azurerm_subnet" "Subrede_Privada" {
  name                 = "SubredePri"
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.Grupo_de_recursos.name
  address_prefixes     = ["172.16.2.0/24"]
}

# Criar Grupo de Segurança
resource "azurerm_network_security_group" "Grupo_de_Seguranca_Linux" {
  name                = "Grupo_de_Segurança_Linux"
  location            = azurerm_resource_group.Grupo_de_recursos.location
  resource_group_name = azurerm_resource_group.Grupo_de_recursos.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Criar Grupo de Segurança
resource "azurerm_network_security_group" "Grupo_de_Seguranca_Windows" {
  name                = "Grupo_de_Segurança_Windows"
  location            = azurerm_resource_group.Grupo_de_recursos.location
  resource_group_name = azurerm_resource_group.Grupo_de_recursos.name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Criar Interface de IP Público Linux
resource "azurerm_public_ip" "public_ip_linux" {
 name                = "public-ip-linux"
 location            = azurerm_resource_group.Grupo_de_recursos.location
 resource_group_name = azurerm_resource_group.Grupo_de_recursos.name
 allocation_method   = "Dynamic"
}

# Criar Interface de rede e Associar IP público na interface Linux
resource "azurerm_network_interface" "Interface_de_rede_Linux" {
 name                      = "Interface_de_rede_Linux"
 location                 = azurerm_resource_group.Grupo_de_recursos.location
 resource_group_name       = azurerm_resource_group.Grupo_de_recursos.name

 ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subrede_Publica.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_linux.id
 }
}

# Criar Interface de IP Público Windows
resource "azurerm_public_ip" "public_ip_windows" {
 name                = "public-ip-windows"
 location            = azurerm_resource_group.Grupo_de_recursos.location
 resource_group_name = azurerm_resource_group.Grupo_de_recursos.name
 allocation_method   = "Dynamic"
}

# Criar Interface de rede e Associar IP público na interface Windows
resource "azurerm_network_interface" "Interface_de_rede_Windows" {
 name                      = "Interface_de_rede_Windows"
 location                 = azurerm_resource_group.Grupo_de_recursos.location
 resource_group_name       = azurerm_resource_group.Grupo_de_recursos.name

 ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subrede_Publica.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_windows.id
 }
}

# Criar Maquina Virtual Linux
resource "azurerm_linux_virtual_machine" "linux" {
  name                = "linux"
  resource_group_name = azurerm_resource_group.Grupo_de_recursos.name
  location            = azurerm_resource_group.Grupo_de_recursos.location
  size                = "Standard_DS1_v2"
  disable_password_authentication = false

  admin_username = "adminuser"
  admin_password = "laispamela19@"

  network_interface_ids = [
    azurerm_network_interface.Interface_de_rede_Linux.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

}

# Criar Maquina Virtual Windows


# Criar Maquina Virtual Windows
resource "azurerm_windows_virtual_machine" "windows" {
 name                = "Windows"
 resource_group_name = azurerm_resource_group.Grupo_de_recursos.name
 location            = azurerm_resource_group.Grupo_de_recursos.location
 size                = "Standard_DS1_v2"
 admin_username      = "adminuser"
 admin_password      = "Senai@134134"

 network_interface_ids = [
    azurerm_network_interface.Interface_de_rede_Windows.id
 ]
 #Criando disco sem redundancia
 os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
 }
#Selecionar a imagem do Wimdows Server Datacenter 2016
 source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
 }

 computer_name = "windowsvm"
 provision_vm_agent = true
 enable_automatic_updates = true
}

# Cria um endereço IP público para o Load Balancer no Azure
resource "azurerm_public_ip" "ip_publico_lb" {
    name                = "public-ip-lb"                             # Nome do endereço IP público
    location            = azurerm_resource_group.Grupo_de_recursos.location    # Localização do endereço IP público
    resource_group_name = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
    allocation_method   = "Static"                                   # Método de alocação do endereço IP
    sku                 = "Standard"                                 # SKU do endereço IP
}

# Cria um Load Balancer no Azure
resource "azurerm_lb" "loadb" {
    name                = "load-balancer"                            # Nome do Load Balancer
    resource_group_name = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
    location            = azurerm_resource_group.Grupo_de_recursos.location    # Localização do Load Balancer
    sku                 = "Standard"                                 # SKU do Load Balancer

    frontend_ip_configuration {
        name                          = "PublicIPAddress"            # Nome da configuração do IP frontal
        public_ip_address_id          = azurerm_public_ip.ip_publico_lb.id  # ID do endereço IP público
    }
}

# Cria um Grupo de Segurança de Rede para o Load Balancer no Azure
resource "azurerm_network_security_group" "lbsg" {
    name                = "lbsg"                                     # Nome do grupo de segurança
    location            = azurerm_resource_group.Grupo_de_recursos.location    # Localização do grupo de segurança
    resource_group_name = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
}

# Define uma regra de segurança para permitir o tráfego TCP na porta 80 para o Load Balancer no Azure
resource "azurerm_network_security_rule" "regras_lbsg" {
    name                        = "regras_lbsg"                       # Nome da regra de segurança
    priority                    = 1001                               # Prioridade da regra
    direction                   = "Inbound"                          # Direção do tráfego
    access                      = "Allow"                            # Tipo de acesso permitido
    protocol                    = "Tcp"                              # Protocolo utilizado
    source_port_range           = "*"                                # Intervalo de portas de origem
    destination_port_range      = "80"                               # Porta de destino
    source_address_prefix       = "*"                                # Prefixo de endereço de origem
    destination_address_prefix = "*"                                # Prefixo de endereço de destino
    network_security_group_name = azurerm_network_security_group.lbsg.name  # Nome do grupo de segurança de rede associado
    resource_group_name         = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
}

# Associa o Grupo de Segurança de Rede à Subrede Pública no Azure
resource "azurerm_subnet_network_security_group_association" "associar_gps" {
    subnet_id                 = azurerm_subnet.Subrede_Publica.id       # ID da subrede pública
    network_security_group_id = azurerm_network_security_group.lbsg.id # ID do grupo de segurança de rede
}

# Configuração do pool de back-end para o Load Balancer no Azure
resource "azurerm_lb_backend_address_pool" "pool_back_end" {
    name            = "Pool-de-Back-end"                            # Nome do pool de back-end
    loadbalancer_id = azurerm_lb.loadb.id                           # ID do Load Balancer
}

# Define a investigação de integridade para o Load Balancer no Azure
resource "azurerm_lb_probe" "lb_probe" {
    name                  = "Investigacao-na-Porta-HTTP"            # Nome da investigação de integridade
    loadbalancer_id       = azurerm_lb.loadb.id                     # ID do Load Balancer
    protocol              = "Http"                                  # Protocolo utilizado na investigação
    port                  = 80                                      # Porta utilizada na investigação
    request_path          = "/"                                     # Caminho da requisição para a investigação
}

# Define a regra do balanceador de carga no Azure
resource "azurerm_lb_rule" "lb_regas" {
    name                              = "LBregas"                   # Nome da regra do balanceador de carga
    loadbalancer_id                   = azurerm_lb.loadb.id          # ID do Load Balancer
    frontend_ip_configuration_name    = azurerm_lb.loadb.frontend_ip_configuration[0].name  # Nome da configuração do IP frontal
    protocol                          = "Tcp"                       # Protocolo utilizado na regra
    frontend_port                     = 80                          # Porta do frontend
    backend_port                      = 80                          # Porta do backend
    probe_id                          = azurerm_lb_probe.lb_probe.id  # ID da investigação de integridade
    backend_address_pool_ids          = [azurerm_lb_backend_address_pool.pool_back_end.id]  # IDs do pool de back-end
}

# Cria uma Interface de IP Público para cada máquina virtual no Azure
resource "azurerm_public_ip" "vm_public_ip" {
    count               = 2                                          # Número de IPs públicos a serem criados
    name                = "ip-vm-${count.index}"                     # Nome da interface de IP público
    location            = azurerm_resource_group.Grupo_de_recursos.location    # Localização da interface de IP público
    resource_group_name = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
    allocation_method   = "Static"                                   # Método de alocação do endereço IP
    sku                 = "Standard"                                 # SKU do endereço IP
}

# Cria as máquinas virtuais Linux no Azure
resource "azurerm_linux_virtual_machine" "linuxlb" {
    count                = 2                                          # Número de máquinas virtuais a serem criadas
    name                 = "vm-${count.index}"                        # Nome da máquina virtual
    resource_group_name  = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado
    location             = azurerm_resource_group.Grupo_de_recursos.location    # Localização da máquina virtual
    size                 = "Standard_DS1_v2"                         # Tamanho da máquina virtual
    admin_username       = "adminuser"                               # Nome do usuário administrador
    admin_password       = "Senai@134@134"                           # Senha do usuário administrador
    disable_password_authentication = false                         # Desativa a autenticação por senha

    custom_data = base64encode(var.custom_data_script)               # Script personalizado a ser executado na inicialização

    network_interface_ids = [
        azurerm_network_interface.vm_network_interface[count.index].id  # IDs das interfaces de rede associadas
    ]

    os_disk {
        caching              = "ReadWrite"                            # Configuração de cache do disco
        storage_account_type = "Standard_LRS"                         # Tipo de conta de armazenamento
    }

    source_image_reference {
        publisher = "Canonical"                                      # Editor da imagem
        offer     = "UbuntuServer"                                   # Oferta da imagem
        sku       = "18.04-LTS"                                      # SKU da imagem
        version   = "latest"                                         # Versão da imagem
    }
}

# Cria as interfaces de rede para as máquinas virtuais Linux no Azure
resource "azurerm_network_interface" "vm_network_interface" {
    count               = 2                                          # Número de interfaces de rede a serem criadas
    name                = "vm-${count.index}-network-interface"       # Nome da interface de rede
    location            = azurerm_resource_group.Grupo_de_recursos.location    # Localização da interface de rede
    resource_group_name = azurerm_resource_group.Grupo_de_recursos.name        # Nome do grupo de recursos associado

    ip_configuration {
        name                          = "vm-${count.index}-ip-configuration"  # Nome da configuração de IP
        subnet_id                     = azurerm_subnet.Subrede_Publica.id      # ID da subrede associada
        private_ip_address_allocation = "Dynamic"                             # Alocação de endereço IP privado
        public_ip_address_id          = azurerm_public_ip.vm_public_ip[count.index].id  # ID do endereço IP público
    }
}

# Associa as interfaces de rede ao pool de back-end do Load Balancer no Azure
resource "azurerm_network_interface_backend_address_pool_association" "pool_association" {
    count                 = length(azurerm_network_interface.vm_network_interface)  # Número de associações a serem criadas
    network_interface_id = azurerm_network_interface.vm_network_interface[count.index].id  # ID da interface de rede
    ip_configuration_name = azurerm_network_interface.vm_network_interface[count.index].ip_configuration[0].name  # Nome da configuração de IP
    backend_address_pool_id = azurerm_lb_backend_address_pool.pool_back_end.id  # ID do pool de back-end
}

# Define o script de inicialização das máquinas virtuais Linux no Azure
variable "custom_data_script" {
    default = <<EOF
#!/bin/bash
# Atualiza os pacotes de instalação
sudo apt update -y
# Instala o Apache2 e o Crontab
sudo apt install apache2 cron -y
# Habilita a inicialização do Apache2 junto com o sistema
sudo systemctl enable apache2
# Inicia o Apache2
sudo systemctl start apache2
# Cria um script para colocar o hostname no site
echo 'echo "Site na Maquina Virtual: $(hostname)" > /var/www/html/index.html' > /cron.sh
# Dá permissão de execução ao script
chmod +x /cron.sh
# Define a execução do script a cada minuto no Crontab
echo '* * * * * root /cron.sh' > /etc/crontab
EOF
}
