#Importou os modulos Flask, flask_cors, subprocess
from flask import Flask, request, jsonify
from flask_cors import CORS
import json
#Serve para executar vários processos ao mesmo tempo
import subprocess

#Criando a API
app = Flask(__name__)

# CORS esta relacionando a segurança
# é como um firewall onde vou liberar apenas 
# o FrontEnd a conectar com essa API
CORS(app)

# ----------------------------------------------------AZURE-----------------------------------------------------------#

# Criar Grupo de Recusos na Azure
def criar_grupo_recursos(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_resource_group.Grupo_de_recursos'], cwd=terraform_dir, check=True)
        print("Grupo de Recursos criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Grupo de Recursos: {e}")
        
# Criar Conta de Armazenamento Azure
def criar_conta_armazenamento(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_storage_account.Conta_de_armazenamento'], cwd=terraform_dir, check=True)
        print("Conta de Armazenamento criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Conta de Armazenamento: {e}")
        
# Criar VNET Azure - Redes Virtuais
def criar_vnet(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_virtual_network.VNET'], cwd=terraform_dir, check=True)
        print("VNET criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar VNET: {e}")
        
# Criar Subrede Pública Azure
# Criar Subrede Pública Azure


# Criar Subrede Pública Azure
def criar_subrede_publica_az(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_subnet.Subrede_Publica'], cwd=terraform_dir, check=True)
        print("Subrede Pública criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Subrede Pública: {e}")


# Criar Subrede Privada Azure
def criar_subrede_privada_az(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_subnet.Subrede_Privada'], cwd=terraform_dir, check=True)
        print("Subrede Privada criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Subrede Privada: {e}")

# Criar Grupo de Segurança Linux Azure
def criar_grupo_seguranca_linux_az(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_network_security_group.Grupo_de_Seguranca_Linux'], cwd=terraform_dir, check=True)
        print("Grupo de Segurança criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Grupo de Segurança: {e}")
        
# Criar Grupo de Segurança Windows Azure
def criar_grupo_seguranca_Wind_az(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_network_security_group.Grupo_de_Seguranca_Windows'], cwd=terraform_dir, check=True)
        print("Grupo de Segurança criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Grupo de Segurança: {e}")

# Criar Interface de IP Público Linux e Associar Azure
def criar_interface_ip_linux(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_public_ip.public_ip_linux', '-target=azurerm_network_interface.Interface_de_rede_Linux'], cwd=terraform_dir, check=True)
        print("Interface de IP Público Linux criada e associada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Interface de IP Público Linux: {e}")

# Criar Interface de IP Público Windows e Associar Azure
def criar_interface_ip_windows(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_public_ip.public_ip_windows', '-target=azurerm_network_interface.Interface_de_rede_Windows'], cwd=terraform_dir, check=True)
        print("Interface de IP Público Windows criada e associada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Interface de IP Público Windows: {e}")

# Criar Maquina Virtual Windows Azure
def criar_maquina_virtual_win(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_windows_virtual_machine.windows'], cwd=terraform_dir, check=True)
        print("Máquina Virtual Windows criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Máquina Virtual Windows: {e}")

# Criar Load Balancer
def criar_load_balancer_azure(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', 
                        '-target=azurerm_public_ip.ip_publico_lb',
                        '-target=azurerm_lb.loadb',
                        '-target=azurerm_network_security_group.lbsg',
                        '-target=azurerm_network_security_rule.regras_lbsg',
                        '-target=azurerm_subnet_network_security_group_association.associar_gps',
                        '-target=azurerm_lb_backend_address_pool.pool_back_end',
                        '-target=azurerm_lb_probe.lb_probe',
                        '-target=azurerm_lb_rule.lb_regas',
                        '-target=azurerm_public_ip.vm_public_ip',
                        '-target=azurerm_linux_virtual_machine.linuxlb',
                        '-target=azurerm_network_interface.vm_network_interface',
                        '-target=azurerm_network_interface_backend_address_pool_association.pool_association'
                        ], cwd=terraform_dir, check=True)
        print("LoadBalancer criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Load Balancer: {e}")

# Criar Maquina Virtual Linux Azure
def criar_maquina_virtual_linux(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=azurerm_linux_virtual_machine.linux'], cwd=terraform_dir, check=True)
        print("Máquina Virtual Linux criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Máquina Virtual Linux: {e}")

# Função para criar recursos na Azure com base na solicitação do usuário
def Criar_AZURE(resources_to_create):
    terraform_dir = './API-Back/azure/'
    messages = []

    # Mapeamento de recursos para funções de criação
    resource_functions = {
        'resource_group': criar_grupo_recursos,
        'storage_account': criar_conta_armazenamento,
        'virtual_network': criar_vnet,
        'subnet_publica': criar_subrede_publica_az,
        'subnet_privada': criar_subrede_privada_az,
        'network_security_linux': criar_grupo_seguranca_linux_az,
        'network_security_windows': criar_grupo_seguranca_Wind_az,
        'public_ip_linux': criar_interface_ip_linux,
        'public_ip_windows': criar_interface_ip_windows,
        'linux_virtual_machine': criar_maquina_virtual_linux,
        'windows_virtual_machine': criar_maquina_virtual_win,
        'load_balancer': criar_load_balancer_azure,
    }

    for resource in resources_to_create:
        try:
            # Verifica se a função correspondente ao recurso existe no mapeamento
            if resource in resource_functions:
                # Chama a função correspondente ao recurso
                resource_functions[resource](terraform_dir)
                messages.append(f"{resource.capitalize()} criado com sucesso!")
            else:
                messages.append(f"Recurso não reconhecido: {resource}")
        except Exception as e:
            messages.append(f"Erro ao criar {resource}: {str(e)}")

    return messages

# Destruir Recursos na AZURE
def Destruir_AZURE():
    terraform_dir = './azure/'
    try:
        # Destroi os recursos criados pelo Terraform
        subprocess.run(['terraform', 'destroy', '-auto-approve'], cwd=terraform_dir, check=True)
        return "Azure resources destroyed"
    except subprocess.CalledProcessError as e:
        return f"Error destroying Azure resources: {e.output}"

# ----------------------------------------------------AWS-----------------------------------------------------------#

# Função para criar VPC
def criar_vpc(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_vpc.vpc'], cwd=terraform_dir, check=True)
        print("VPC criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar VPC: {e}")

# Função para criar Subrede Pública
def criar_subrede_publica_aws(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_subnet.Subrede_Publica'], cwd=terraform_dir, check=True)
        print("Subrede Pública criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Subrede Pública: {e}")

# Função para criar Subrede Privada
def criar_subrede_privada_aws(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_subnet.Subrede_Privada'], cwd=terraform_dir, check=True)
        print("Subrede Privada criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Subrede Privada: {e}")

# Função para criar Gateway de Internet
def criar_internet_gateway(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_internet_gateway.igw'], cwd=terraform_dir, check=True)
        print("Gateway de Internet criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Gateway de Internet: {e}")

# Função para criar Tabela de Rotas
def criar_tabela_rotas(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_route_table.public'], cwd=terraform_dir, check=True)
        print("Tabela de Rotas criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Tabela de Rotas: {e}")

# Função para associar subrede pública à tabela de rotas
def associar_subrede_tabela(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_route_table_association.public'], cwd=terraform_dir, check=True)
        print("Subrede Pública associada à Tabela de Rotas com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao associar Subrede Pública à Tabela de Rotas: {e}")

# Função para criar Grupo de Segurança Linux
def criar_grupo_seguranca_Linux_aws(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_security_group.Grupo_de_Seguranca_LInux'], cwd=terraform_dir, check=True)
        print(f"Grupo de Segurança criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Grupo de Segurança: {e}")
        
# Função para criar Grupo de Segurança Windows
def criar_grupo_seguranca_Windows_aws(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_security_group.Grupo_de_Seguranca_Windows'], cwd=terraform_dir, check=True)
        print(f"Grupo de Segurança criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Grupo de Segurança: {e}")

# Função para criar instância EC2 Linux
def criar_instancia_ec2_Linux(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_instance.linux'], cwd=terraform_dir, check=True)
        print(f"Instância EC2 Linux criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Instância EC2 Linux: {e}")

# Criar Load Balancer AWS
def criar_load_balancer_aws(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', 
                        '-target=aws_lb.loadb',
                        '-target=aws_internet_gateway.igw',
                        '-target=aws_route_table_association.public',
                        '-target=aws_security_group.lb_sg',
                        '-target=aws_lb_target_group.grupo_de_destino',
                        '-target=aws_lb_listener.lb_listener',
                        '-target=aws_instance.Linuxlb',
                        '-target=aws_lb_target_group_attachment.grupo_target'
                        ], cwd=terraform_dir, check=True)
        print("LoadBalancer criado com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Load Balancer: {e}")

    
# Função para criar instância EC2 Windows
def criar_instancia_ec2_Windows(terraform_dir):
    try:
        subprocess.run(['terraform', 'apply', '-auto-approve', '-target=aws_instance.windows'], cwd=terraform_dir, check=True)
        print(f"Instância EC2 Windows criada com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao criar Instância EC2 Windows: {e}")

# Função para criar recursos na AWS com base na solicitação do usuário        
def criar_AWS(resources_to_create):
    terraform_dir = './aws/'
    messages = []

    resource_functions = {
        'vpc': lambda: criar_vpc,
        'subrede_publica': lambda: criar_subrede_publica_aws(terraform_dir),
        'subrede_privada': lambda: criar_subrede_privada_aws(terraform_dir),
        'internet_gateway': lambda: criar_internet_gateway(terraform_dir),
        'tabela_rotas': lambda: criar_tabela_rotas(terraform_dir),
        'associar_subrede_tabela': lambda: associar_subrede_tabela(terraform_dir),
        'grupo_seguranca_linux': criar_grupo_seguranca_Linux_aws(terraform_dir),
        'grupo_seguranca_windows': lambda: criar_grupo_seguranca_Windows_aws(terraform_dir),
        'ec2_linux': lambda: criar_instancia_ec2_Linux(terraform_dir),
        'ec2_windows': lambda: criar_instancia_ec2_Windows(terraform_dir),
        'load_balancer': lambda: criar_load_balancer_aws(terraform_dir)
    }

    for resource in resources_to_create:
        func = resource_functions.get(resource)
        if func:
            func()
            messages.append(f"{resource.capitalize()} criado com sucesso!")
        else:
            messages.append(f"Recurso não reconhecido: {resource}")

    return messages

# Destruir Recursos na AWS
def Destruir_AWS():
    terraform_dir = './aws/'
    try:
        # Destroi os recursos criados pelo Terraform
        subprocess.run(['terraform', 'destroy', '-auto-approve'], cwd=terraform_dir, check=True)
        return "AWS resources destroyed"
    except subprocess.CalledProcessError as e:
        return f"Error destroying AWS resources: {e.output}"
    
# Endpoint de Criação de Recursos
@app.route('/api', methods=['POST', 'OPTIONS'])
def Criar():
    data = request.get_json()
    platform = data.get('platform')
    resources_to_create = data.get('resources_to_create')

    if not platform or not resources_to_create:
        return jsonify({"error": "Platform and resources to create are required"}), 400
    
    if platform == 'aws':
        # Chama a função para criar recursos na Azure
        message = criar_AWS(resources_to_create)
        return jsonify({"message": message}), 200
    if platform == 'azure':
        # Chama a função para criar recursos na Azure
        message = Criar_AZURE(resources_to_create)
        return jsonify({"message": message}), 200
    else:
       return jsonify({"error": "Invalid platform"}), 400

# Endipoint para Destruir
@app.route('/destruir', methods=['POST'])
def Destruir():
    data = request.get_json()
    platform = data.get('platform')

    if not platform:
        return jsonify({"error": "Platform is required"}), 400

    if platform == 'aws':
        # Chama a função para destruir recursos na AWS
        message = Destruir_AWS()
        return jsonify({"message": message}), 200
    elif platform == 'azure':
        # Chama a função para destruir recursos no Azure
        message = Destruir_AZURE()
        return jsonify({"message": message}), 200
    else:
        return jsonify({"error": "Invalid platform"}), 400

# Endipoint para exibir MENU
@app.route('/menu', methods=['GET'])
def menu():
    menu_options = {
        "aws": {
            "create": [
                "vpc",
                "subnet_publica",
                "subnet_privada",
                "internet_gateway",
                "route_table",
                "route_table_association",
                "security_group_linux",
                "security_group_windows",
                "ec2_linux",
                "ec2_windows"
            ],
            "destroy": "Destruir todos os recursos AWS"
        },
        "azure": {
            "create": [
                "resource_group",
                "storage_account",
                "virtual_network",
                "subnet_publica",
                "subnet_privada",
                "network_security_group",
                "public_ip_linux",
                "public_ip_windows",
                "interface_de_rede_linux",
                "interface_de_rede_windows",
                "linux_virtual_machine",
                "windows_virtual_machine"
            ],
            "destroy": "Destruir todos os recursos Azure"
        }
    }
    return jsonify(menu_options), 200

if __name__ == '__main__':
    app.run(debug=True)
