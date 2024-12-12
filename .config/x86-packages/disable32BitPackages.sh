#!/bin/bash

# File: disable32BitPackages.sh
# Description: Script to disable 32-bit architecture support
# Version: 1.0.0
# Author: Sterbweise
# Last Updated: 12/12/2024

# Import global configurations
if [ "$1" = "--disable" ]; then
    source /opt/T5Server/.config/config.sh
fi

# Function to disable 32-bit architecture support
disable32BitPackages() {
    {
        if dpkg --print-foreign-architectures | grep -q i386; then
            dpkg --remove-architecture i386
            apt-get update -y
        fi
    } > /dev/null 2>&1 &
    showProgressIndicator "$(getMessage "bit")"
    
    # Verify removal
    if dpkg --print-foreign-architectures | grep -q i386; then
        printf "${COLORS[RED]}Error:${COLORS[RESET]} 32-bit package deactivation failed.\n"
        printf "Attempting deactivation again...\n"
        dpkg --remove-architecture i386
        apt-get update -y
        if dpkg --print-foreign-architectures | grep -q i386; then
            printf "${COLORS[RED]}Error:${COLORS[RESET]} Deactivation failed. Please check your system and try again.\n"
            exit 1
        fi
    fi

    if [ "$1" = "--disable" ]; then
        printf "${COLORS[GREEN]}Success:${COLORS[RESET]} 32-bit architecture support has been disabled.\n"
    fi
}

# Run the disable function if --disable is provided
if [ "$1" = "--import" ]; then
    :
elif [ "$1" = "--disable" ]; then
    disable32BitPackages
else
    echo "Usage: $0 [--disable] | [--import]"
    echo "This script disables 32-bit architecture support. Use --disable or no argument to proceed with disabling."
fi