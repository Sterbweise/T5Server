#!/bin/bash

# File: installFirewall.sh
# Description: Script to install and configure firewall for the Plutonium Call of Duty: Black Ops Server
# Version: 1.0.0
# Author: Sterbweise
# Last Updated: 12/12/2024

# Import global configurations
if [ "$1" = "--install" ]; then
    source /opt/T5Server/.config/config.sh
fi

# Function to install firewall
installFirewall() {
    local ssh_port="$1"
    {
        # Check if UFW is already installed
        if ! command -v ufw &> /dev/null; then
            apt install ufw -y
        fi

        # Check if fail2ban is already installed
        if ! command -v fail2ban-client &> /dev/null; then
            apt install fail2ban -y
        fi

        # Configure UFW
        ufw allow "$ssh_port"/tcp
        ufw default allow outgoing
        ufw default deny incoming
        ufw -f enable
    } > /dev/null 2>&1 &
    showProgressIndicator "$(getMessage "firewall_install")"
    
    # Verify installation
    if ! command -v ufw &> /dev/null || ! command -v fail2ban-client &> /dev/null
    then
        printf "${COLORS[RED]}Error:${COLORS[RESET]} Firewall installation failed.\n"
        printf "Attempting reinstallation...\n"
        {
            apt install ufw fail2ban -y
            ufw allow "$ssh_port"/tcp
            ufw default allow outgoing
            ufw default deny incoming
            ufw -f enable
        } > /dev/null 2>&1 &
        showProgressIndicator "$(getMessage "firewall_reinstall")"
        
        if ! command -v ufw &> /dev/null || ! command -v fail2ban-client &> /dev/null
        then
            printf "${COLORS[RED]}Error:${COLORS[RESET]} Reinstallation failed. Please check your internet connection and try again.\n"
            exit 1
        fi
    fi

    if [ "$1" = "--install" ]; then
        printf "${COLORS[GREEN]}Success:${COLORS[RESET]} Firewall has been installed and configured.\n"
    fi
}

# Run the installation function if --install or --import is provided
if [ "$1" = "--import" ]; then
    :
elif [ "$1" = "--install" ]; then
    if [ -z "$2" ]; then
        echo "Error: SSH port is required."
        echo "Usage: $0 [--install] <ssh_port>"
        exit 1
    fi
    installFirewall "$2"
elif [ "$1" = "--install" ] && [ -n "$2" ]; then
    installFirewall "$2"
else
    echo "Usage: $0 [--install] <ssh_port> | [--import]"
    echo "This script installs the firewall or imports the configuration. Use --install followed by the SSH port number to proceed with installation or --import to import the configuration."
fi
