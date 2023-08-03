#Apêndice IX - Instalação e Configuração Inicial do Servidor Zabbix

####################################################################################################
#Passo 2: Ajustes da VM e Atualização dos Pacotes.
# Atualização dos pacotes
sudo apt update && sudo apt upgrade -y
# Ajuste do nome da vm
sudo hostnamectl set-hostname zabbix

####################################################################################################
#Passo3: Instalação prévia do banco de dados MySql, e configuração de uma senha segura
# Instala o Mysql Server e inicia os serviços
sudo apt install mysql-server -y && sudo systemctl start mysql.service 
# Checar o funcionamento e conexão
sudo systemctl start mysql.service
sudo mysql -u root
#Por padrão, não é exigido senha para que o usuário root do ubuntu se conecte ao  mysql.
#Atribuição de senha ao usuário root do mysql
sudo mysql
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'grupo4';
mysql> exit
mysql -u root -p
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
mysql> exit

####################################################################################################
#Passo 4: Instalação do Zabbix via Pacotes
#Os passos a seguir estão baseados na documentação oficial, disponível em:  https://www.zabbix.com/download
# Install Zabbix repository
wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-4%2Bubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.2-4+ubuntu22.04_all.deb
sudo apt update

#Install Zabbix server, frontend, agent
sudo apt install zabbix-server-mysql \
zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Create initial database
sudo mysql -u root 
grupo4
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'P@$$w0rd';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

#Configure the database for Zabbix server
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
# Check users' credentials for future account recoveration
sudo mysql -u root -p grupo4
mysql> set global log_bin_trust_function_creators = 0;
mysql> use zabbix;
mysql> select username, passwd from users;
+----------+--------------------------------------------------------------+
| username | passwd  (zabbix)                                             |
+----------+--------------------------------------------------------------+
| Admin    | $2y$10$92nDno4n0Zm7Ej7Jfsz8WukBfgSS/U0QkIuu8WkJPihXBb2A1UrEK |
| guest    | $2y$10$89otZrRNmde97rIyzclecuk6LwKAsHN0BcvoOKGjbT.BwMBfm7G06 |
+----------+--------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> quit;
#Configure the database for Zabbix server
#Edit file /etc/zabbix/zabbix_server.conf
sudo vim /etc/zabbix/zabbix_server.conf
DBPassword=P@$$w0rd

#Start Zabbix server and agent processes
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

#Check process status
sudo systemctl status zabbix-server 
sudo systemctl status zabbix-agent 
sudo systemctl status apache2

# SSL apache2 module enabling
sudo a2enmod ssl
sudo systemctl restart apache2

# Creating the selfsigned certificate
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 1825 -newkey rsa:2048 \ 
-keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt

#Country Name (2 letter code) [XX]:BR
#State or Province Name (full name) []:DF
#Locality Name (eg, city) [Default City]:Brasilia
#Organization Name (eg, company) [Default Company Ltd]:Grupo4
#Organizational Unit Name (eg, section) []:grupo4.com
#Common Name (eg, your name or your server's hostname) []:192.168.10.9
#Email Address []:grupo4@grupo4.com

# Checking certificate created
ls -1 /etc/apache2/ssl/
# apache.crt
# apache.key

#Enabling Virtual Hosts for HTTPS default redirect
sudo vim /etc/apache2/sites-available/zabbix.grupo4.com.br.conf

<VirtualHost *:80>
        ServerAdmin admin@grupo4.com.br
        ServerName zabbix.grupo4.com.br
        ServerAlias *zabbix..grupo4.com.br
        DocumentRoot /usr/share/zabbix
        #Redirecionamento para conexão segura
        Redirect / https://192.168.10.9/
</VirtualHost>
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin admin@grupo4.com.br
                DocumentRoot /usr/share/zabbix
                ServerName zabbix.grupo4.com.br
                ServerAlias *.zabbix.grupo4.com.br
                SSLEngine on
                SSLCertificateFile /etc/apache2/ssl/apache.crt
                SSLCertificateKeyFile /etc/apache2/ssl/apache.key
                ErrorLog ${APACHE_LOG_DIR}/zabbix_error.log
                CustomLog ${APACHE_LOG_DIR}/zabbix_access.log combined
                Header set Strict-Transport-Security "max-age=31536000"
        </VirtualHost>
</IfModule>

# Disable default Virtual Host
cd /etc/apache2/sites-available/
sudo a2dissite ./*
# Enabling zabbix virtual host
sudo a2ensiste  zabbix.grupo4.com.br.conf
sudo systemctl restart apache2
# Assessing frontend 
http://192.168.10.9/
user: Admin
password: zabbix

####################################################################################################
#Passo 5: Cheque de Comunicação com os Hosts a Serem Monitorados
#Os dispositivos que estão com o monitoramento SNMP habilitados, podem ser verificados a partir dos exemplos a seguir:
#Obs.: os dispositivos instalados conforme os Apêndices II, III, e IV, já estão com o monitoramento SNMP habilitados.
# Exemplo de consultas SNMP versão 
# Buscando dados dos roteadores instalados conforme Passo 4 do Apêndice IV
snmpwalk -v3 -l authPriv -u admin -a MD5 -A "zabbix123" -x DES -X "zabbix123" 172.16.4.1   1.3.6.1.2.1.1.5.0
snmpwalk -v2c -c grupo004 172.16.4.1    1.3.6.1.2.1.1.5.0

# Buscando os dados dos Switchs instalados conforme Passo 4 do Apêndice IV
snmpwalk -v2c -c grupo004 192.168.10.1    1.3.6.1.2.1.1.5.0
snmpwalk -v3 -l authPriv -u grupo004 -a MD5 -A "grupo004" -x AES128 -X "grupo004" 192.168.10.1   1.3.6.1.2.1.1.5.0

####################################################################################################
#Passo 7: Inclusão Manual de Hosts
openssl rand -hex 32
# psk-key
52eb2f1bc2a55c6e096009d91d24fddffb285ace62e64e8ec5dcc1c7e749638a


####################################################################################################
#Passo 8: Configuração dos Servidores Clientes Linux para o SNMP v3 (Opcional)
sudo apt update ; 
sudo apt install -y snmpd libsnmp-dev

# Add snmp user, before start snmp services
sudo systemctl stop snmpd
sudo systemctl status snmpd

# Create snmp v3 user
# sudo net-snmp-create-v3-user  -ro -a MD5 -A [AuthPass]  -x DES -X [PrivatePass] [USER]
sudo net-snmp-create-v3-user  -ro -a MD5 -A grupo004 -x DES -X grupo004 grupo004 

# Configure snmpd services
sudo vim /etc/snmp/snmpd.conf
agentAddress udp:192.168.1.20:161


# Start the snmpd service
sudo systemctl enable snmpd
sudo systemctl start snmpd
sudo systemctl status snmpd
sudo journalctl --unit snmpd  --since "2023-02-15"

# Checking snmp status (from Zabbix server)
snmpwalk -v3 -l authPriv -u grupo004 -a MD5 -A "grupo004" -x DES -X "grupo004" 192.168.10.11  1.3.6.1.2.1.1.5.0

snmpwalk -v2c -c public 192.168.10.11  1.3.6.1.2.1.1.5.0


