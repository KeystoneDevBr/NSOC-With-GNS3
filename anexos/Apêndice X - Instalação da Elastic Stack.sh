#Apêndice X - Instalação da Elastic Stack

####################################################################################################
#Passo 1: Instalação do Elasticsearch no Servidor  Ubuntu 22.04 via Pacotes
# Import the Elasticsearch PGP Key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# Install from thye APT repository
sudo apt-get install apt-transport-https

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

sudo apt-get update && sudo apt-get install elasticsearch

# The password and certificate and keys are output to your terminal. For example:
# -------Security autoconfiguration information-------
#
# Authentication and authorization are enabled.
# TLS for the transport and HTTP layers is enabled and configured.
#
# The generated password for the elastic built-in superuser is : NDTGYDbusmrofamukSac

#Edit the Elasticsearch file configurations
sudo su -
sudo vim /etc/elasticsearch/elasticsearch.yml

# Uncomment this lines
# ---------------------------------- Network -----------------------------------
#
# By default Elasticsearch is only accessible on localhost. Set a different
# address here to expose this node on the network:
#
network.host: 192.168.10.11
#
# By default Elasticsearch listens for HTTP traffic on the first free port it
# finds starting at 9200. Set a specific HTTP port here:
#
http.port: 9200
# For more information, consult the network module documentation.
# Enable the Elastic search service
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service


# Check that journal system
sudo journalctl --unit elasticsearch --since  "2023-02-07 16:00:16"


# Check that esasticsearch is running
https://192.168.10.11:9200/
user: elastic
password: 20mMROrxepOFEwc0NBa0

# Expected output
{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "8.6.1",
    "build_type" : "tar",
    "build_hash" : "f27399d",
    "build_flavor" : "default",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "9.4.2",
    "minimum_wire_compatibility_version" : "1.2.3",
    "minimum_index_compatibility_version" : "1.2.3"
  },
  "tagline" : "You Know, for Search"
}


####################################################################################################
#Passo 2: Instalação do Kibana no Ubuntu 22.04 via Pacotes
# Install kibana by package
sudo apt-get install kibana

# Generate SSL Certificate
sudo mkdir /etc/kibana/ssl

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/kibana/ssl/kibana.key -out /etc/kibana/ssl/kibana.crt

sudo chmod 664 -R /etc/kibana/ssl/
sudo chown kibana.kibana -R /etc/kibana/ssl
# Edit kibana.conf
sudo vim /etc/kibana/kibana.yml
# =================== System: Kibana Server ===================
 server.port: 5601
 server.host: "192.168.10.11"
# =================== System: Kibana Server (Optional) ===================
 server.ssl.enabled: true
 server.ssl.certificate: /etc/kibana/ssl/kibana.crt
 server.ssl.key: /etc/kibana/ssl/kibana.key

# Generate token to kibana
sudo  /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
# Output
eyJ2ZXIiOiI4LjYuMSIsImFkciI6WyIxOTIuMTY4LjEwLjExOjkyMDAiXSwiZmdyIjoiNzQzZjVjZDg2NzcyYjkzODYzZjJkNzYxYzNmOGZkZGFiY2MyMDFmYTY3ZjkzYjAwNTM5YzJlMDY1Y2I1MTBjMSIsImtleSI6InlsMkdMWVlCU1RONjM5YXFXS1dmOjFQNkUxWFFEVHpxTi1SQVcxWVBfUVEifQ==

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service
sudo journalctl --unit kibana --since  "2023-02-07 16:00:16"

# Access: 
https://192.168.10.11:5601/?code=722198


sudo /usr/share/kibana/bin/kibana-verification-code 
# Output ⇒ Your verification code is:  048 645 

####################################################################################################
#Passo 3: Instalação do Logstash no Ubuntu 22.04 via Pacote
# Instalação do pacote do logstash
sudo apt-get update && sudo apt-get install logstash

# Habilitando o serviço do logstash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable logstash.service
sudo systemctl start logstash.service
sudo journalctl --unit logstash --since "2023-02-07"
