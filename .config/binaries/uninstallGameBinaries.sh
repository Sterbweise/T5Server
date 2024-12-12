#!/bin/bash

# File: uninstallGameBinaries.sh
# Description: Script to uninstall game binaries for the Plutonium Call of Duty: Black Ops Server
# Version: 1.0.0
# Author: Sterbweise
# Last Updated: 12/12/2024

# Import global configurations
if [ "$1" = "--uninstall" ]; then
    source /opt/T5Server/.config/config.sh
fi

# Function to uninstall game binaries
uninstallGameBinaries () {
    {
        # Remove the main game directories
        rm -rf "$WORKDIR/Server"

        # Remove the Plutonium directory
        rm -rf "$WORKDIR/Plutonium"

        # Remove the Resources directory if it exists
        if [ -d "$WORKDIR/Resources" ]; then
            rm -rf "$WORKDIR/Resources"
        fi

        # Remove the entire WORKDIR if it's empty
        if [ -z "$(ls -A "$WORKDIR")" ]; then
            rm -rf "$WORKDIR"
        fi

    } > /dev/null 2>&1 &
    showProgressIndicator "$(getMessage "uninstall_binary")"
    
    # Verify uninstallation
    if [ ! -d "$WORKDIR/Server" ] && [ ! -d "$WORKDIR/Plutonium" ]; then
        printf "${COLORS[GREEN]}Success:${COLORS[RESET]} Game binaries have been uninstalled.\n"
    else
        printf "${COLORS[RED]}Error:${COLORS[RESET]} Game binaries uninstallation may have failed.\n"
        printf "You can try manually removing the directories:\n"
        printf "$WORKDIR/Server\n"
        printf "$WORKDIR/Plutonium\n"
    fi
}

# Run the uninstallation function if --uninstall is provided
if [ "$1" = "--import" ]; then
    :
elif [ "$1" = "--uninstall" ]; then
    uninstallGameBinaries
else
    echo "Usage: $0 [--uninstall] | [--import]"
    echo "This script uninstalls game binaries. Use --uninstall or no argument to proceed with uninstallation."
fi
