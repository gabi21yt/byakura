Network Configuration Script

This Bash script helps you configure a static IP address on a Linux system. It prompts you for the necessary network details and then updates the network configuration file accordingly. The script also creates a backup of the current configuration before making any changes and restarts the networking service to apply the new settings.
Features

    Prompts for:
        Desired IP address
        Subnet mask
        Gateway address
        DNS servers
    Automatically determines the active network interface
    Backs up the current network configuration file
    Applies the new network settings
    Restarts the networking service to apply changes

Script Usage

    Run the script: Execute the script with root or sudo privileges.

    bash

    sudo ./configure_network.sh

    Input the required information:
        IP address (e.g., 192.168.1.10)
        Subnet mask (e.g., 255.255.255.0)
        Gateway (e.g., 192.168.1.1)
        DNS servers (space-separated, e.g., 8.8.8.8 8.8.4.4)

    Script execution: The script will automatically:
        Detect the active network interface (assumed to be eth0 in this script)
        Backup the current /etc/network/interfaces file
        Write the new configuration to /etc/network/interfaces
        Restart the networking service to apply the changes

Example

bash

$ sudo ./configure_network.sh
Enter the desired IP address (e.g., 192.168.1.10): 192.168.1.100
Enter the subnet mask (e.g., 255.255.255.0): 255.255.255.0
Enter the gateway address (e.g., 192.168.1.1): 192.168.1.1
Enter DNS servers (space-separated, e.g., 8.8.8.8 8.8.4.4): 8.8.8.8 8.8.4.4

After running the script, the new IP configuration will be applied and the network service will be restarted.
Notes

    Ensure that the script is run with sufficient privileges to modify network settings.
    The script assumes the active network interface is detected correctly; manual adjustment may be needed for different configurations.
    Backup of the existing network configuration is made to /etc/network/interfaces.bak.

Feel free to modify the script according to your network setup or requirements.
