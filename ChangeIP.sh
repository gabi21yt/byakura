#!/bin/bash

# Demande à l'utilisateur de choisir son OS
echo "Quel système d'exploitation utilisez-vous ?"
echo "1) Debian"
echo "2) Ubuntu"
read -p "Entrez le numéro correspondant à votre OS (1 ou 2): " os_choice

# Demande des informations communes à Debian et Ubuntu
read -p "Entrez l'adresse IP souhaitée (par exemple 192.168.1.10): " ip_address
read -p "Entrez le masque de sous-réseau (par exemple 255.255.255.0): " subnet_mask
read -p "Entrez l'adresse de la passerelle (gateway) (par exemple 192.168.1.1): " gateway
read -p "Entrez les serveurs DNS (séparés par des espaces, par exemple 8.8.8.8 8.8.4.4): " dns_servers

# Détecte l'interface réseau
interface=$(ip -o -4 route show to default | awk '{print $5}')

if [ "$os_choice" == "1" ]; then
    # Configuration pour Debian
    echo "Configuration pour Debian"

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

    echo "La configuration IP a été appliquée pour Debian."

elif [ "$os_choice" == "2" ]; then
    # Configuration pour Ubuntu
    echo "Configuration pour Ubuntu"

    # Convertir l'adresse IP et le masque de sous-réseau en notation CIDR
    cidr_suffix=$(ipcalc -p $ip_address $subnet_mask | cut -d= -f2)
    ip_cidr="${ip_address}/${cidr_suffix}"

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
        - $ip_cidr
      gateway4: $gateway
      nameservers:
        addresses:
          - $(echo $dns_servers | sed 's/ /\\n          - /g')
EOT

    # Applique la nouvelle configuration réseau
    netplan apply

    echo "La configuration IP a été appliquée pour Ubuntu."

else
    echo "Choix invalide. Veuillez exécuter à nouveau le script et entrer 1 pour Debian ou 2 pour Ubuntu."
    exit 1
fi
