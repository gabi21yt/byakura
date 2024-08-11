# ChangeIP

Static IP Configuration Script for Debian and Ubuntu
Description

This Bash script allows you to configure a static IP address on a Debian or Ubuntu machine. It guides you through the configuration process by asking for necessary information such as IP address, subnet mask, gateway, and DNS servers. The script automatically detects the primary network interface and applies the changes based on the selected operating system.
Prerequisites

    A Debian or Ubuntu machine.
    Superuser (root) privileges to run the script.

Instructions
1. Download and Preparation

    Download the script to your machine.
    Ensure the script is executable by using the following command:

    bash

    chmod +x configurer_ip_fixe.sh

2. Running the Script

    Run the script with superuser privileges:

    bash

    sudo ./configurer_ip_fixe.sh

3. Operating System Selection

The script will prompt you to select your operating system:

    1) For Debian
    2) For Ubuntu

Enter the number corresponding to your operating system and press Enter.
4. Entering Network Information

The script will then ask you to provide the following information:

    IP Address: Enter the IP address you wish to configure (e.g., 192.168.1.10).
    Subnet Mask: Enter the corresponding subnet mask (e.g., 255.255.255.0).
    Gateway: Enter the gateway address (e.g., 192.168.1.1).
    DNS Servers: Enter the DNS server addresses, separated by spaces (e.g., 8.8.8.8 8.8.4.4).

5. Applying the Changes

The script will apply the changes based on the selected operating system:

    For Debian:
        The /etc/network/interfaces file will be modified.
        The networking service will be restarted to apply the changes.

    For Ubuntu:
        The netplan configuration file (/etc/netplan/01-netcfg.yaml) will be modified.
        The netplan apply command will be executed to apply the changes.

6. Confirmation

Once the changes are applied, a message will confirm that the IP configuration was successful.
Backup

The script creates a backup of the configuration files before modifying them:

    Debian: A copy of /etc/network/interfaces is saved as /etc/network/interfaces.bak.
    Ubuntu: A copy of /etc/netplan/01-netcfg.yaml is saved as /etc/netplan/01-netcfg.yaml.bak.

You can restore these files manually if needed.

Limitations

   The script assumes the primary network interface is the one used for the default route. If your network configuration is more complex, you may need to modify the script to specify the exact interface.
   
   The script is designed for simple network configurations and does not account for advanced scenarios such as managing multiple interfaces, advanced routing, or VLAN configurations.

Disclaimer

Use this script with caution, especially on production systems. It is recommended to test the script in a controlled environment before using it on critical servers.
