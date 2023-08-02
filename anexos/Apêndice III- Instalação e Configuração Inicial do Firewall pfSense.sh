#Apêndice III- Instalação e Configuração Inicial do Firewall pfSense

####################################################################################################
#Passo 10: Configuração do Servido SNMPv3 e do Zabbix Agent
# Consulta os firewalls pelo IP individual
snmpwalk -v3 -l authPriv -u grupo004 -a SHA -A 'grupo004' -x AES -X 'grupo004' 192.168.10.12  1.3.6.1.2.1.1.5.0
snmpwalk -v3 -l authPriv -u grupo004 -a SHA -A 'grupo004' -x AES -X 'grupo004' 192.168.10.13  1.3.6.1.2.1.1.5.0
# Consulta qual firewall está respondendo pelo Master
snmpwalk -v3 -l authPriv -u grupo004 -a SHA1 -A 'grupo004' -x AES128 -X 'grupo004' 192.168.10.14 1.3.6.1.2.1.1.5.0


####################################################################################################
#Passo 12: Criação de Regra Para Bloquei da Aplicação Personalizada Ping com Dialog, descrita no Apêndice VIII
# Regra customizada.
# Regra customizada.
drop icmp any any -> any any (msg:" ICMP PACKAGE WITH LARGE SIZE"; dsize:>64; classtype:policy-violation ; sid: 1000001;)


