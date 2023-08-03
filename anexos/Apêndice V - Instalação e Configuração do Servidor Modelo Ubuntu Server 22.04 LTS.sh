#Apêndice V - Instalação e Configuração do Servidor Modelo Ubuntu Server 22.04 LTS

####################################################################################################
#Passo 3: Atualização da máquina virtual e instalação de pacotes básicos.
#Pacotes básicos
sudo apt-get update && sudo apt upgrade -y && sudo apt install net-tools && sudo apt install snmp && sudo apt install && sudo apt install traceroute -y

####################################################################################################
#Passo 5: instalação do agente zabbix (Apenas para máquinas que serão monitoradas)
# Instaçaão e habilitação do agent zabbix
sudo apt install zabbix-agent
# Informar o endereço do servidor
# Atribuir o enderço do servidor zabbix
sudo nano /etc/zabbix/zabbix_agentd.conf
Server=192.168.10.9
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

####################################################################################################
#Passo 6: instalação e configuração básica do firewall iptables
#Instala o iptables e o pacote para torná-lo persistente
sudo apt-get install iptables -y && sudo apt-get install iptables-persistent -y
#Salva as configurações corrente no arguivo rules.v4 e rules.v6 se for o caso.
sudo iptables-save > /etc/iptables/rules.v4
#Abre o arquivo de configuração.
sudo vim /etc/iptables/rules.v4
#Reiniciar o firewall local para aplicar as regras
sudo systemctl restart  iptables && sudo systemctl status iptables
# Visualizar as regras em execução
sudo iptables -L -v -n



####################################################################################################
#Passo 7: Configuração do cliente NTP
# Configuração de fuso horário
sudo timedatectl set-timezone America/Sao_Paulo
# Instalar o serviço NTP
sudo apt-get install ntp
# Editar o arquivo de configuração
server <IP-Virtual-do-Gateway>
sudo /etc/init.d/ntp restart
sudo /etc/init.d/ntp status
#Verificar a sincronização
sudo ntpq -pn
sudo ntpd
