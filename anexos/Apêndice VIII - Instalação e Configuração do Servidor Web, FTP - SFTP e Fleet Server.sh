#Apêndice VIII - Instalação e Configuração do Servidor Web, FTP/SFTP e Fleet Server

####################################################################################################
#Passo 1: Instalação do Servidor Apache com HTTP e HTTPS.
# Atualização de pacotes
sudo apt update && sudo apt upgrade -y
# Atribuição de nomes
sudo hostnamectl set-hostname web-server
# Instalação do servidor web apache
sudo apt install apache2 -y
sudo systemctl status apache2

####################################################################################################
#Passo 2: Personalização da Página Inicial.
sudo mkdir /var/www/grupo4folder
sudo chown -R $USER:$USER /var/www/grupo4folder/
sudo chmod -R 755 /var/www/grupo4folder/

vim /var/www/grupo4folder/index.html

<!DOCTYPE html>
<html>
    <head>
<meta charset="utf-8">
        <title>Grupo 04!</title>
    </head>
    <body>
        <h1>Grupo 04</h1>
        <h1>Seu domínio está em funcionamento!</h1>
    </body>
</html>

####################################################################################################
#Passo 3: Configuração certificado HTTPS autoassinado e do Virtual Host para exibição da página.
#Cria os certificados com openssl
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
sudo a2enmod ssl

#Configura o virtual host para o domínio gurpo.com.br
sudo vim /etc/apache2/sites-available/grupo4.com.br.conf

<VirtualHost *:80>
        ServerAdmin admin@grupo4.com.br
        ServerName grupo4.com.br
        ServerAlias www.grupo4.com.br
        DocumentRoot /var/www/grupo4folder
        #Redirecionamento para conexão segura
        #Redirect / https://grupo4.com.br/
        ErrorLog ${APACHE_LOG_DIR}/grupo4_error.log
        CustomLog ${APACHE_LOG_DIR}/grupo4_access.log combined
</VirtualHost>
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin admin@grupo4.com.br
                DocumentRoot /var/www/grupo4folder
                ServerName grupo4.com.br
                ServerAlias www.grupo4.com.br
                SSLEngine on
                SSLCertificateFile /etc/apache2/ssl/apache.crt
                SSLCertificateKeyFile /etc/apache2/ssl/apache.key
                ErrorLog ${APACHE_LOG_DIR}/grupo4_error.log
                CustomLog ${APACHE_LOG_DIR}/grupo4_access.log combined
        </VirtualHost>
</IfModule>

####################################################################################################
#Aplicando as configurações do Virutal Host no apache
sudo apache2ctl configtest
cd /etc/apache2/sites-available
sudo a2dissite ./*
sudo a2ensite grupo4.com.br.conf
sudo sudo /etc/init.d/apache2 restart
sudo systemctl status apache2.service

####################################################################################################
#Passo 5: Instalação do SFTP.
# Atualização dos pacotes
sudo apt update && sudo apt upgrade


# Instalação do pacote vsftp para prover os serviços FTP e SFTP
sudo apt install vsftpd -y


# Verifica se o serviço está funcionando 
systemctl status vsftpd.service --no-pager -l

# Cria um usuário exclusivo para cliente FTP
sudo adduser ftpcliente
 New password: grupo004
 Retype new password: grupo004
 passwd: password updated successfully
 Changing the user information for ftpcliente
 Enter the new value, or press ENTER for the default
        Full Name []: 
        Room Number []: 
        Work Phone []: 
        Home Phone []: 
        Other []: 
 Is the information correct? [Y/n] y

# Ajuste das permissões de acesso ao diretório do novo usuário.
sudo chown grupo4.ftpcliente -R /home/ftpcliente/
sudo chmod 774 -R /home/ftpcliente/

# Cria arquivo para teste de download.
echo "From my FTP server" | tee /home/ftpcliente/from-server.txt
sudo chown grupo4.ftpcliente -R /home/ftpcliente/from-server.txt


# Após instalação do pacote vsftpd, é necessário ajustar suas  configurações.
sudo vim /etc/vsftpd.conf  
  # Restrição de acesso apenas à pasta individual do usuário logado
  chroot_local_user=YES
  # Habilita conexão segura. Neste exemplo, o certificado gerado no Passo 3 é aproveitado.
  rsa_cert_file=/etc/apache2/ssl/apache.crt
  rsa_private_key_file=/etc/apache2/ssl/apache.key
  ssl_enable=Yes

# Restart do serviço vsftpd para habilitação dos ajuste das configurações.
sudo systemctl restart vsftpd.service
sudo systemctl status  vsftpd.service

####################################################################################################
#Passo 5.1: Teste de Upload e Download de arquivos
# Conexão insegura com FTP - Apenas permissão de download
ftp -p ftpcliente@192.168.20.10
ftp> pwd
Remote working directory: /home/ftpcliente
ftp> ls
from-server.txt    
ftp> get from-server.txt 

# Conexão Segura dom SFTP
sftp -p ftpcliente@192.168.20.10
sftp> pwd
Remote working directory: /home/ftpcliente
sftp> ls
from-server.txt    
sftp> get from-server.txt 

sftp> put from-cliente.txt 
sftp> ls
from-server.txt 
from-cliente.txt

####################################################################################################
#Passo 7: Ajuste das regras do Firewall Iptables.
#Instalar o firewall iptables e persiste as regras atuais
#bash
#Instala o iptables, caso não estaja ativo
sudo apt-get install iptables -y
#instal o pacote para tornar o iptables persistente
sudo apt-get install iptables-persistent -y
#Salva as configurações corrente no arguivo rules.v4 e rules.v6 se for o caso.
sudo iptables-save > /etc/iptables/rules.v4
#Abre o arquivo de configuração.
sudo vim /etc/iptables/rules.v4


####################################################################################################
#Regras personalizadas para o servidor web.
#!/bin/bash/
###########################################################################################
# file: /etc/iptables/rules.v4
# Author: Fagne Tolentino Reges Date: 10/02/2022
# Description: Basic rules for Ubuntu Server with some services, like Apache2.
###########################################################################################
# ------------------------ Filter Table Configuration -------------------------------------
*filter
# Default Police. Drop all connection for chains INPUT, FORWARD and OUTPUT
-P INPUT DROP
-P OUTPUT DROP
-P FORWARD DROP
#___________________________ Chain INPUT __________________________________________________
# Allow traffic on loopback
-A INPUT -i lo -j ACCEPT

#Allow ICMP (ping) request
-A INPUT -p icmp -j ACCEPT

# Allow SSH Connection from network 192.168.30.0/28 (GERÊNCIA)
-A INPUT -s 192.168.30.0/28 -d 192.168.20.0/28 -p tcp -m tcp --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# Allow ssh output connection from this host 
-A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow HTTP and HTTPS connections
-A INPUT -p tcp -m multiport --dports 80,443,9243,8220,9200 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow MYSQL output connection from this host
-A INPUT -p tcp --sport 3306 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow HTTP and HTTPS Elastic Agent  outgoing connection from this host
-A INPUT -p tcp -m multiport --sport 80,443,9243,8220,9200 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow DNS outgoing  connection from this host
-A INPUT -p udp --sport 53 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SNMP input connections
-A INPUT -p udp -m udp --sport 513:65535 --dport 161 -m state --state NEW,ESTABLISHED -j ACCEPT
#___________________________ Chain FORWARD ________________________________________________
# None here
#___________________________ Chain OUTPUT _________________________________________________
# Allow traffic on loopback
-A OUTPUT -o lo -j ACCEPT

#Allow ICMP (ping) request
-A OUTPUT -p icmp -j ACCEPT

# Allow SSH input Connection  from  network 192.168.30.0/28 (GERÊNCIA)
-A OUTPUT -s 192.168.20.0/28 -d 192.168.30.0/28 -p tcp -m tcp --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

# Allow SSH output connection  from this host
-A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow HTTP and HTTPS connections
-A OUTPUT -p tcp -m multiport --sports 80,443,9243,8220,9200 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow MySQL output connection from this host
-A OUTPUT -p tcp --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow HTTP and HTTPS  and Elastic Agent outgoing connection from this host
-A OUTPUT -p tcp -m multiport --dport 80,443,9243,8220,9200  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow DNS outgoing connection from this host
-A OUTPUT -p udp --dport 53 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# Allow SNMP input connections
-A OUTPUT -p udp -m udp --sport 161 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

# make sure nothing comes or goes out of this box
-A INPUT -j DROP
-A FORWARD -j DROP
-A OUTPUT -j DROP

# ------------------------ Filter Table Configuration END ---------------------------------
# Save configurations
COMMIT

####################################################################################################
#Aplica as novas regras do firewall
#Reiniciar o firewall local para aplicar as regras
sudo systemctl restart  iptables
sudo systemctl status iptables
# Visualizar as regras em execução
sudo iptables -L -v -n


###################################################################################################
