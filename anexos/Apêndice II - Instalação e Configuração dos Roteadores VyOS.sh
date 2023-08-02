#Apêndice II - Instalação e Configuração dos Roteadores VyOS

####################################################################################################
#Roteador ISP-1
#Router ISP-1 Configuration
configure
set system host-name ISP-1
set service ssh port 22
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth1 address 172.16.4.1/30
set interfaces ethernet eth2 address 172.16.4.9/30
set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 source address '172.16.4.0/24'
set nat source rule 100 translation address 'masquerade'
# OSPF Configuration
set protocols static route 0.0.0.0/0 next-hop 192.168.122.1
set interfaces loopback lo address 10.1.1.1/32
set protocols ospf area 0 network 192.168.122.0/24
set protocols ospf area 0 network 172.16.4.0/30
set protocols ospf area 0 network 172.16.4.8/30
set protocols ospf default-information originate always
set protocols ospf default-information originate metric 10
set protocols ospf default-information originate metric-type 2
set protocols ospf log-adjacency-changes
set protocols ospf parameters router-id 10.1.1.1
set protocols ospf redistribute connected metric-type 2
set protocols ospf redistribute connected route-map CONNECT
set policy route-map CONNECT rule 10 action permit
set policy route-map CONNECT rule 10 match interface lo
# Enable snmp v2 service for zabbix management
set protocols static route 192.168.10.0/28 next-hop 172.16.4.2
set protocols static route 192.168.20.0/28 next-hop 172.16.4.2
set service snmp community grupo004 authorization ro
set service snmp community grupo004 network 172.16.4.16/29
set service snmp community grupo004 client 172.16.4.20
set service snmp trap-target 192.168.10.9 community grupo004 
# Enable snmp v3  service for zabbix managemnt
set service snmp v3 engineid '000000000000000000000001'
set service snmp location 'BACKBONE'
set service snmp v3 view default oid 1
set service snmp v3 group routers mode ro
set service snmp v3 group routers view 'default'
set service snmp v3 user admin auth plaintext-password 'zabbix123'
set service snmp v3 user admin auth type 'md5'
set service snmp v3 user admin group routers
set service snmp v3 user admin privacy plaintext-password 'zabbix123'
set service snmp v3 user admin privacy type 'des'
set service snmp v3 trap-target 192.168.10.9 privacy plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 privacy type des
set service snmp v3 trap-target 192.168.10.9 user admin
set service snmp v3 trap-target 192.168.10.9 auth plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 auth type md5
# Time configuration
set system time-zone America/Sao_Paulo
commit
# save

#set system time-zone America/Sao_Paulo
#set system ntp server 172.24.7.20 prefer

####################################################################################################
#Roteador ISP-2
#Configuração do Roteador ISP-2
configure
set system host-name ISP-2
set service ssh port 22
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth1 address 172.16.4.6/30
set interfaces ethernet eth2 address 172.16.4.10/30
set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 source address '172.16.4.0/24'
set nat source rule 100 translation address 'masquerade'
# OSPF Configuration
set protocols static route 0.0.0.0/0 next-hop 192.168.177.2
set interfaces loopback lo address 10.2.2.2/32
set protocols ospf area 0 network 192.168.177.0/24
set protocols ospf area 0 network 172.16.4.4/30
set protocols ospf area 0 network 172.16.4.8/30
set protocols ospf default-information originate always
set protocols ospf default-information originate metric 10
set protocols ospf default-information originate metric-type 2
set protocols ospf log-adjacency-changes
set protocols ospf parameters router-id 10.2.2.2
set protocols ospf redistribute connected metric-type 2
set protocols ospf redistribute connected route-map CONNECT
set policy route-map CONNECT rule 10 action permit
set policy route-map CONNECT rule 10 match interface lo
# Enable snmp v2 service for zabbix management
set protocols static route 192.168.10.0/28 next-hop 172.16.4.5
set service snmp community grupo004 authorization ro
set service snmp community grupo004 network 172.16.4.16/29
set service snmp community grupo004 client 172.16.4.20
set service snmp trap-target 192.168.10.9 community grupo004 
# Enable snmp v3  service for zabbix managemnt
set service snmp v3 engineid '000000000000000000000002'
set service snmp location 'BACKBONE'
set service snmp v3 view default oid 1
set service snmp v3 group routers mode ro
set service snmp v3 group routers view 'default'
set service snmp v3 user admin auth plaintext-password 'zabbix123'
set service snmp v3 user admin auth type 'md5'
set service snmp v3 user admin group routers
set service snmp v3 user admin privacy plaintext-password 'zabbix123'
set service snmp v3 user admin privacy type 'des'
set service snmp v3 trap-target 192.168.10.9 privacy plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 privacy type des
set service snmp v3 trap-target 192.168.10.9 user admin
set service snmp v3 trap-target 192.168.10.9 auth plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 auth type md5
# Time configuration
set system time-zone America/Sao_Paulo

#commit
#save


####################################################################################################
#Roteador RT-GW
#Configuração do Roteador GW
configure
set system host-name RT-GW
set service ssh port 22
set interfaces ethernet eth0 address 172.16.4.2/30
set interfaces ethernet eth1 address 172.16.4.5/30
set interfaces ethernet eth2 address dhcp
set interface bridge br0 member interface eth3
set interface bridge br0 member interface eth4
set interface bridge br0 address 172.16.4.22/29
#Configure load-balancing
set load-balancing wan interface-health eth0 failure-count 5
set load-balancing wan interface-health eth0 nexthop 172.16.4.1
set load-balancing wan interface-health eth0 test 10 type ping
set load-balancing wan interface-health eth0 test 10 target 192.168.122.1
set load-balancing wan interface-health eth0 test 20 type ping
set load-balancing wan interface-health eth0 test 20 target 192.168.122.1
set load-balancing wan interface-health eth1 failure-count 4
set load-balancing wan interface-health eth1 nexthop 172.16.4.6
set load-balancing wan interface-health eth1 test 10 type ping
set load-balancing wan interface-health eth1 test 10 target 192.168.177.2
set load-balancing wan interface-health eth1 test 20 type ping
set load-balancing wan interface-health eth1 test 20 target 192.168.177.2
set load-balancing wan rule 10 inbound-interface eth2
set load-balancing wan rule 10 interface eth0
set load-balancing wan rule 10 interface eth1
set load-balancing wan disable-source-nat
# OSPF Configuration
set interfaces loopback lo address 10.3.3.3/32
set protocols ospf area 0 network 172.16.4.0/30
set protocols ospf area 0 network 172.16.4.4/30
set protocols ospf area 0 network 172.16.4.12/30
set protocols ospf area 0 network 172.16.4.16/29
set protocols ospf default-information originate always
set protocols ospf default-information originate metric 10
set protocols ospf default-information originate metric-type 2
set protocols ospf log-adjacency-changes
set protocols ospf parameters router-id 10.3.3.3
set protocols ospf redistribute connected metric-type 2
set protocols ospf redistribute connected route-map CONNECT
set policy route-map CONNECT rule 10 action permit
set policy route-map CONNECT rule 10 match interface lo
# Enable snmp v2 service for zabbix management
set protocols static route 192.168.10.0/28 next-hop 172.16.4.20
set protocols static route 192.168.20.0/28 next-hop 172.16.4.20
set service snmp community grupo004 authorization ro
set service snmp community grupo004 network 172.16.4.16/29
set service snmp community grupo004 client 172.16.4.20
set service snmp trap-target 192.168.10.9 community grupo004 
# Enable snmp v3  service for zabbix managemnt
set service snmp v3 engineid '000000000000000000000003'
set service snmp location 'BACKBONE'
set service snmp v3 view default oid 1
set service snmp v3 group routers mode ro
set service snmp v3 group routers view 'default'
set service snmp v3 user admin auth plaintext-password 'zabbix123'
set service snmp v3 user admin auth type 'md5'
set service snmp v3 user admin group routers
set service snmp v3 user admin privacy plaintext-password 'zabbix123'
set service snmp v3 user admin privacy type 'des'
set service snmp v3 trap-target 192.168.10.9 privacy plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 privacy type des
set service snmp v3 trap-target 192.168.10.9 user admin
set service snmp v3 trap-target 192.168.10.9 auth plaintext-password zabbix123
set service snmp v3 trap-target 192.168.10.9 auth type md5
# Time configuration
set system time-zone America/Sao_Paulo
commit
#save
#exit
#show wan-load-balance
#show wan-load-balance status



####################################################################################################
#Host Windows: configuração de rota para o GNS3
# Configuração de roteamento do Windows para os IPS do Backbone
#route add 172.16.4.0 mask 255.255.255.0 <IP da Eth3 do RT-GW>
route add 172.16.4.0 mask 255.255.255.0 192.168.137.242

####################################################################################################