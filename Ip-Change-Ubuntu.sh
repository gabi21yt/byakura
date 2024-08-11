#!/bin/bash

# Demande des informations à l'utilisateur
read -p "Entrez l'adresse IP souhaitée (par exemple 192.168.1.10/24): " ip_address
read -p "Entrez l'adresse de la passerelle (gateway) (par exemple 192.168.1.1): " gateway
read -p "Entrez les serveurs DNS (séparés par des espaces, par exemple 8.8.8.8 8.8.4.4): " dns_servers

# Détermine l'interface réseau (supposons eth0 pour cet exemple)
interface=$(ip -o -4 route show to default | awk '{print $5}')

# Crée une sauvegarde du fichier netplan
netplan_file="/etc/netplan/01-netcfg.yaml"
cp $netplan_file "${netplan_file}.bak"

# Configuration de l'interface avec les nouvelles valeurs
cat <<EOT > $netplan_file
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      dhcp4: no
      addresses:
        - $ip_address
      gateway4: $gateway
      nameservers:
        addresses:
          - $(echo $dns_servers | sed 's/ /\\n          - /g')
EOT

# Applique la nouvelle configuration réseau
netplan apply

echo "La nouvelle configuration IP a été appliquée avec succès."
