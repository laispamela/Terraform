# MENU


#--------------------AWS-------------------------------
# VPC (Virtual Private Cloud)
# Recurso: VPC
# Descrição: Cria uma VPC para isolar seus recursos na AWS.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["vpc"]
}

# Subnets
# Recurso: Subnet_Publica
# Descrição: Cria uma sub-rede pública dentro da VPC.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["subnet_publica"]
}

# Subnets
# Recurso: Subnet_Privada
# Descrição: Cria uma sub-rede privada dentro da VPC.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["subnet_privada"]
}

# Internet Gateway
# Recurso: Internet_Gateway
# Descrição: Permite que instâncias na VPC acessem a internet.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["internet_gateway"]
}

# Route Table
# Recurso: Route_Table
# Descrição: Define as rotas para a VPC.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["route_table"]
}

# Route Table Association
# Recurso: Route_Table_Association
# Descrição: Associa a tabela de rotas à sub-rede pública.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["route_table_association"]
}

# Security Groups
# Recurso: Security_Group_Linux
# Descrição: Permite o tráfego SSH para instâncias Linux.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["security_group_linux"]
}

# Security Groups
# Recurso: Security_Group_Windows
# Descrição: Permite o tráfego RDP para instâncias Windows.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["security_group_windows"]
}

# EC2 Instances
# Recurso: EC2_Linux
# Descrição: Cria uma instância EC2 Linux.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["ec2_linux"]
}

# EC2 Instances
# Recurso: EC2_Windows
# Descrição: Cria uma instância EC2 Windows.
# Exemplo de Solicitação no Postman:
{
   "platform": "aws",
   "resources_to_create": ["ec2_windows"]
}


#--------------------AZURE-------------------------------
# Resource Group
# Recurso: Resource_Group
# Descrição: Cria um grupo de recursos para organizar e gerenciar recursos na Azure.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["resource_group"]
}

# Storage Account
# Recurso: Storage_Account
# Descrição: Cria uma conta de armazenamento para armazenar dados na Azure.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["storage_account"]
}

# Virtual Network
# Recurso: Virtual_Network
# Descrição: Cria uma VNet para isolar seus recursos na Azure.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["virtual_network"]
}

# Subnets
# Recurso: Subnet_Publica
# Descrição: Cria uma sub-rede pública dentro da VNet.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["subnet_publica"]
}

# Subnets
# Recurso: Subnet_Privada
# Descrição: Cria uma sub-rede privada dentro da VNet.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["subnet_privada"]
}

# Network Security Group
# Recurso: Network_Security_Group
# Descrição: Define regras de segurança para a VNet.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["network_security_group"]
}

# Public IPs
# Recurso: Public_IP_Linux
# Descrição: Cria um endereço IP público para acesso externo.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["public_ip_linux"]
}

# Public IPs
# Recurso: Public_IP_Windows
# Descrição: Cria um endereço IP público para acesso externo.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["public_ip_windows"]
}

# Network Interfaces
# Recurso: Interface_de_Rede_Linux
# Descrição: Cria uma interface de rede para a instância Linux.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["interface_de_rede_linux"]
}

# Network Interfaces
# Recurso: Interface_de_Rede_Windows
# Descrição: Cria uma interface de rede para a instância Windows.
# Exemplo de Solicitação no Postman:
{
   "platform": "azure",
   "resources_to_create": ["interface_de_rede_windows"]
}
