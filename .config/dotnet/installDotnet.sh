#!/bin/bash

# File: installDotnet.sh
# Description: Script to install .NET for the Plutonium Call of Duty: Black Ops Server
# Version: 1.0.0
# Author: Sterbweise
# Last Updated: 12/12/2024

# Import global configurations
if [ "$1" = "--install" ]; then
    source /opt/T5Server/.config/config.sh
fi

# Function to install .NET
installDotnet() {
    {
        # Check if dotnet is already installed
        checkAndInstallCommand "wget" "wget"
        if ! command -v dotnet &> /dev/null; then
            # Try to get the package for the current distribution
            PACKAGE_URL="https://packages.microsoft.com/config/$DISTRO/$VERSION/packages-microsoft-prod.deb"
            if ! wget -q --method=HEAD $PACKAGE_URL; then
                # If the package doesn't exist, fall back to Debian 10
                PACKAGE_URL="https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb"
            fi

            # Download and install Microsoft keys and repository
            if [ ! -f /etc/apt/trusted.gpg.d/microsoft.asc.gpg ] || [ ! -f /etc/apt/sources.list.d/microsoft-prod.list ]; then
                wget -q https://packages.microsoft.com/keys/microsoft.asc -O microsoft.asc
                cat microsoft.asc | gpg --dearmor -o microsoft.asc.gpg

                if [ "$VERSION_ID" = "12" ]; then
                    # For Debian 12
                    wget -q https://packages.microsoft.com/config/$ID/$VERSION_ID/prod.list -O microsoft-prod.list
                    mv microsoft-prod.list /etc/apt/sources.list.d/microsoft-prod.list
                    SIGNED_BY_PATH=$(grep -oP "(?<=signed-by=).*(?=\])" /etc/apt/sources.list.d/microsoft-prod.list)
                    mv microsoft.asc.gpg "$SIGNED_BY_PATH"
                else
                    # For other versions
                    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
                    wget -q https://packages.microsoft.com/config/$ID/$VERSION_ID/prod.list -O /etc/apt/sources.list.d/microsoft-prod.list
                    chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
                    chown root:root /etc/apt/sources.list.d/microsoft-prod.list
                fi

                rm -f microsoft.asc
            fi

            # Update packages
            apt-get update

            # Install .NET based on Debian version
            if [ "$VERSION_ID" = "12" ] || [ "$VERSION_ID" = "11" ]; then
                if ! dpkg -s aspnetcore-runtime-8.0 &> /dev/null; then
                    apt-get install -y aspnetcore-runtime-8.0
                fi
            elif [ "$VERSION_ID" = "10" ]; then
                if ! dpkg -s aspnetcore-runtime-7.0 &> /dev/null; then
                    apt-get install -y aspnetcore-runtime-7.0
                fi
            else
                printf "${COLORS[RED]}Error:${COLORS[RESET]} Unsupported Debian version.\n"
                exit 1
            fi

            # Clean apt cache
            apt-get clean
            apt-get autoremove -y
        fi
    } > /var/log/dotnet_install.log 2>&1 &
    showProgressIndicator "$(getMessage "dotnet_install")"
    
    # Verify installation
    if ! command -v dotnet &> /dev/null
    then
        printf "${COLORS[RED]}Error:${COLORS[RESET]} Dotnet installation failed.\n"
        printf "Attempting reinstallation...\n"
        if [ "$VERSION_ID" = "12" ]; then
            apt-get install -y aspnetcore-runtime-8.0
        elif [ "$VERSION_ID" = "11" ]; then
            apt-get install -y aspnetcore-runtime-8.0
        elif [ "$VERSION_ID" = "10" ]; then
            apt-get install -y aspnetcore-runtime-7.0
        else
            printf "${COLORS[RED]}Error:${COLORS[RESET]} Unsupported Debian version.\n"
            exit 1
        fi
        if ! command -v dotnet &> /dev/null
        then
            printf "${COLORS[RED]}Error:${COLORS[RESET]} Reinstallation failed. Please check your internet connection and try again.\n"
            exit 1
        fi
    fi

    if [ "$1" = "--install" ]; then
        printf "${COLORS[GREEN]}Success:${COLORS[RESET]} .NET has been installed.\n"
    fi
}

# Run the installation function if --install or --import is provided
if [ "$1" = "--import" ]; then
    :
elif [ "$1" = "--install" ]; then
    installDotnet
else
    echo "Usage: $0 [--install] | [--import]"
    echo "This script installs .NET or imports the configuration. Use --install or --import to proceed with installation or import."
fi
