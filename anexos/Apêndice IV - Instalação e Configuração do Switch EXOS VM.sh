#Apêndice IV - Instalação e Configuração do Switch EXOS VM

####################################################################################################
#Passo 4: Configurações Individuais dos Switchs EXOS VM

####################################################################################################
#SW-CORE-A 
# Basic Configurations
configure snmp sysName SW-CORE-A
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.1 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.1 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.1 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.1 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.1 255.255.255.0
# Set trunk ports
configure vlan DATA-CENTER add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DMZ  add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan GERENCIA add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DEFAULT add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #access mode
# Opctinal configurations
configure vlan DEFAULT ipaddress 192.168.4.1 255.255.255.240
save configuration


####################################################################################################
#SW-CORE-B 
# Basic Configurations
configure snmp sysName SW-CORE-B
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.2 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.2 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.2 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.2 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.2 255.255.255.0
# Set trunk ports
configure vlan DATA-CENTER add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DMZ  add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan GERENCIA add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
#configure vlan DEFAULT add ports 1 2 3 4 5 6 7 8 9 10 11 12 tagged #access mode
# Opctinal configurations
configure vlan DEFAULT ipaddress 192.168.4.2 255.255.255.240
save configuration


####################################################################################################
#SW-DIST-A 
# Basic Configurations
configure snmp sysName SW-DIST-A 
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.3 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.3 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.3 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.3 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.3 255.255.255.0
# Set trunk ports
configure vlan DATA-CENTER add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DMZ  add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan GERENCIA add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DEFAULT add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #access mode
# Opctinal configurations
configure vlan DEFAULT ipaddress 192.168.4.3 255.255.255.240
save configuration


####################################################################################################
#SW-DIST-B 
# Basic Configurations
configure snmp sysName SW-DIST-B
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.4 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.4 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.4 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.4 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.4 255.255.255.0
# Set trunk ports
configure vlan DATA-CENTER add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DMZ  add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan GERENCIA add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 3 4 5 6 7 8 9 10 11 tagged #trunk mode
configure vlan DEFAULT add ports 1 2 3 4 5 6 7 8 9 10 11 tagged #access mode
# Opctinal configurations
configure vlan DEFAULT ipaddress 192.168.4.4 255.255.255.240
save configuration


####################################################################################################
#SW-DIST-CAMPUS-A-B
# Basic Configurations
configure snmp sysName SW-DIST-CAMPUS-A-B
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.8 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.8 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.8 255.255.255.0
configure vlan DEFAULT ipaddress 192.168.4.8 255.255.255.240
# Set trunk ports
configure vlan DATA-CENTER add ports 1 2 tagged #trunk mode
configure vlan DMZ  add ports 1 2 tagged #trunk mode
configure vlan GERENCIA add ports  1 2 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 2 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 tagged #trunk mode
configure vlan DEFAULT add ports 1 2 tagged #access mode
save configuration

####################################################################################################
#SPANNING TREE CONFIGURATION
# Basic Configurations
configure mstp revision 3
configure stpd s0 mode mstp cist
enable s0 auto-bind vlan 10-50
enable stpd s0
#configure s0 ports auto-edge on 1-11
#show stpd s0 detail
#show stpd s0 ports

####################################################################################################
#SW-ACCESS-DC 
# Basic Configurations
configure snmp sysName SW-ACCESS-DC
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.5 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.5 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.5 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.5 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.5 255.255.255.0
# Set trunk ports
configure vlan DATA-CENTER add ports 2 3 4 5 6 7 8 9 10 11 12 untagged #access mode
configure vlan DATA-CENTER add ports 1 tagged #trunk mode
# Opctinal configurations
configure vlan DMZ  add ports 1 tagged #trunk mode
configure vlan GERENCIA add ports  1 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 tagged #trunk mode
configure vlan DEFAULT add ports 1 tagged #trunk mode
configure vlan DEFAULT ipaddress 192.168.4.5 255.255.255.240
save configuration



####################################################################################################
#SW-ACCESS-DMZ 
# Basic Configurations
configure snmp sysName SW-ACCESS-DMZ
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
configure vlan DATA-CENTER ipaddress 192.168.10.6 255.255.255.240
configure vlan DMZ ipaddress 192.168.20.6 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.6 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.6 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.6 255.255.255.0
# Set trunk ports
configure vlan DMZ add ports 2 3 4 5 6 7 8 9 10 11 12 untagged #access mode
configure vlan DATA-CENTER add ports 1 tagged #trunk mode
configure vlan DMZ  add ports 1 tagged #trunk mode
configure vlan GERENCIA add ports  1 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 tagged #trunk mode
configure vlan DEFAULT add ports 1 tagged #trunk mode
configure vlan DEFAULT ipaddress 192.168.4.6 255.255.255.240
save configuration


####################################################################################################
#SW-ACCESS-GERENCIA
# Basic Configurations
configure snmp sysName SW-ACCESS-GERENCIA
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
create vlan Default tag 1 description Default 
create vlan DATA-CENTER tag 10 description DATA-CENTER
create vlan DMZ tag 20 description DMZ
create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Add IP address to vlans
configure vlan DATA-CENTER ipaddress 192.168.10.7 255.255.255.240
#configure vlan DMZ ipaddress 192.168.20.7 255.255.255.240
configure vlan GERENCIA ipaddress 192.168.30.7 255.255.255.240
configure vlan CAMPUS-A ipaddress 192.168.40.7 255.255.255.0
configure vlan CAMPUS-B ipaddress 192.168.50.7 255.255.255.0
# Set trunk ports
configure vlan GERENCIA add ports 2 3 4 5 6 7 8 9 10 11 12 untagged #access mode
configure vlan GERENCIA add ports 1 tagged #trunk mode
# Opctinal configurations
configure vlan DMZ  add ports 1 tagged #trunk mode
configure vlan DATA-CENTER add ports  1 tagged #trunk mode
configure vlan CAMPUS-A add ports  1 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 tagged #trunk mode
configure vlan DEFAULT add ports 1 tagged #trunk mode
configure vlan DEFAULT ipaddress 192.168.4.7 255.255.255.240
save configuration


####################################################################################################
#SW-ACCESS-CAMPUS-A
# Basic Configurations
configure snmp sysName SW-ACCESS-CAMPUS-A
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
#create vlan DATA-CENTER tag 10 description DATA-CENTER
#create vlan DMZ tag 20 description DMZ
#create vlan GERENCIA tag 30 description GERENCIA
create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Set trunk ports
configure vlan CAMPUS-A add ports  3 4 5 6 7 8 9 10 11 12 untagged #access mode
#configure vlan DATA-CENTER add ports 1 2 tagged #trunk mode
#configure vlan DMZ  add ports 1 2 tagged #trunk mode
#configure vlan GERENCIA add ports 1 2 tagged #trunk mode
configure vlan CAMPUS-A add ports 1 2 tagged #trunk mode
configure vlan CAMPUS-B add ports  1 2 tagged #trunk mode
#configure vlan DEFAULT add ports 1 2 tagged #trunk mode
save configuration



####################################################################################################
#SW-ACCESS-CAMPUS-B
# Basic Configurations
configure snmp sysName SW-ACCESS-CAMPUS-A
configure vlan 1 delet ports 1 2 3 4 5 6 7 8 9 10 11 12
# Create Vlans
#create vlan Default tag 1 description Default 
#create vlan DATA-CENTER tag 10 description DATA-CENTER
#create vlan DMZ tag 20 description DMZ
#create vlan GERENCIA tag 30 description GERENCIA
#create vlan CAMPUS-A tag 40 description CAMPUS-A
create vlan CAMPUS-B tag 50 description CAMPUS-B
# Set trunk ports
configure vlan CAMPUS-B add ports  2 3 4 5 6 7 8 9 10 11 12 untagged #access mode
#configure vlan DATA-CENTER add ports 1 tagged #trunk mode
#configure vlan DMZ  add ports 1 tagged #trunk mode
#configure vlan GERENCIA add ports 1 tagged #trunk mode
#configure vlan CAMPUS-A add ports 1  tagged #trunk mode
configure vlan CAMPUS-B add ports  1  tagged #trunk mode
#configure vlan DEFAULT add ports 1  tagged #trunk mode
save configuration




####################################################################################################
#Passo 5: Cheque de monitoramento SNMP v2c e v3
# Exemplo de consultas SNMP
# Buscando dados dos roteadores instalados conforme Passo 4 
snmpwalk -v3 -l authPriv -u admin -a MD5 -A "zabbix123" -x DES -X "zabbix123" 172.16.4.1 1.3.6.1.2.1.1.5.0

snmpwalk -v2c -c grupo004 172.16.4.1 1.3.6.1.2.1.1.5.0

# Buscando os dados dos Switchs instalados conforme Passo 4
snmpwalk -v3 -l authPriv -u grupo004 -a MD5 -A "grupo004" -x AES128 -X "grupo004" 192.168.4.1  1.3.6.1.2.1.1.5.0

snmpwalk -v2c -c grupo004 192.168.10.1 1.3.6.1.2.1.1.5.0