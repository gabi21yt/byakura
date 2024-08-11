#!/bin/bash

# Demande des informations à l'utilisateur
read -p "Entrez l'adresse IP souhaitée (par exemple 192.168.1.10): " ip_address
read -p "Entrez le masque de sous-réseau (par exemple 255.255.255.0): " subnet_mask
read -p "Entrez l'adresse de la passerelle (gateway) (par exemple 192.168.1.1): " gateway
read -p "Entrez les serveurs DNS (séparés par des espaces, par exemple 8.8.8.8 8.8.4.4): " dns_servers

# Détermine l'interface réseau (supposons eth0 pour cet exemple)
interface=$(ip -o -4 route show to default | awk '{print $5}')

# Crée une sauvegarde du fichier interfaces
cp /etc/network/interfaces /etc/network/interfaces.bak

# Configuration de l'interface avec les nouvelles valeurs
cat <<EOT > /etc/network/interfaces
auto $interface
iface $interface inet static
    address $ip_address
    netmask $subnet_mask
    gateway $gateway
    dns-nameservers $dns_servers
EOT

# Redémarre le service réseau pour appliquer les changements
systemctl restart networking

echo "La nouvelle configuration IP a été appliquée avec succès."
