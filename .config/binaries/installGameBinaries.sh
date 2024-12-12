#!/bin/bash

# File: installGameBinaries.sh
# Description: Script to install game binaries for the Plutonium Call of Duty: Black Ops Server
# Version: 1.0.0
# Author: Sterbweise
# Last Updated: 12/12/2024

# Import global configurations
if [ "$1" = "--install" ]; then
    source /opt/T5Server/.config/config.sh
fi

# Function to install game binaries
installGameBinaries () {
    {
        # Create directory structure for Plutonium
        mkdir -p "$WORKDIR/Plutonium/storage/t5/"{gamesettings,scripts,mods}

        # Clone T5ServerConfigs repository
        rm -rf /tmp/T5ServerConfigs
        checkAndInstallCommand "git" "git"
        git clone https://github.com/xerxes-at/T5ServerConfig.git /tmp/T5ServerConfigs

        # Install rsync if not present
        checkAndInstallCommand "rsync" "rsync"

        # Copy configuration files
        if [ -d "/tmp/T5ServerConfigs/localappdata/Plutonium/storage/t5" ]; then
            mkdir -p "$WORKDIR/Plutonium/storage/t5"
            rsync -a --delete "/tmp/T5ServerConfigs/localappdata/Plutonium/storage/t5/" "$WORKDIR/Plutonium/storage/t5"
        fi

        # Clean up T5ServerConfigs
        rm -rf /tmp/T5ServerConfigs

        # Download required files from torrent
        checkAndInstallCommand "aria2c" "aria2"
        # Clean up any existing pluto_t5_full_game files/directories in /tmp
        rm -rf /tmp/pluto_t5_full_game*
        aria2c --dir=/tmp --seed-time=0 --console-log-level=error --summary-interval=1 --select-file=$(aria2c -S "$WORKDIR/Resources/sources/pluto_t5_full_game.torrent" | grep -E "main/|zone/|binkw32.dll" | cut -d'|' -f1 | tr '\n' ',' | tr -d ' ') "$WORKDIR/Resources/sources/pluto_t5_full_game.torrent"

        # Move downloaded files to Resources
        rsync -a "/tmp/pluto_t5_full_game/main" "$WORKDIR/Server/"
        rsync -a "/tmp/pluto_t5_full_game/zone" "$WORKDIR/Server/"
        rsync -a "/tmp/pluto_t5_full_game/binkw32.dll" "$WORKDIR/Server/binkw32.dll"

        # Clean up downloaded files
        rm -rf /tmp/pluto_t5_full_game

        # Setup Plutonium updater
        if [ ! -f "$WORKDIR/Plutonium/plutonium-updater" ]; then
            cd "$WORKDIR/Plutonium/" || exit
            checkAndInstallCommand "wget" "wget"
            wget -q -O plutonium-updater.tar.gz https://github.com/mxve/plutonium-updater.rs/releases/latest/download/plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
            checkAndInstallCommand "tar" "tar"
            tar xf plutonium-updater.tar.gz plutonium-updater
            rm plutonium-updater.tar.gz
            chmod +x plutonium-updater
        fi

        # Make T5Server.sh executable
        chmod +x "$WORKDIR/Plutonium/T5Server.sh"
    } > /dev/null 2>&1 &
    showProgressIndicator "$(getMessage "binary")"
    
    # Verify installation
    if [ ! -f "$WORKDIR/Plutonium/plutonium-updater" ]; then
        printf "${COLORS[RED]}Error:${COLORS[RESET]} Game binaries installation failed.\n"
        printf "You can try running the installation script separately by executing:\n"
        printf "cd .config/binaries && ./installGameBinaries.sh\n"
    fi
}

# Run the installation function if --install is provided
if [ "$1" = "--import" ]; then
    :
elif [ "$1" = "--install" ]; then
    installGameBinaries
else
    echo "Usage: $0 [--install] | [--import]"
    echo "This script installs game binaries. Use --install or no argument to proceed with installation."
fi
