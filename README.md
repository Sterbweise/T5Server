# T5 Server - Plutonium Black Ops Server Installer

![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Debian](https://img.shields.io/badge/Debian-10%20%7C%2011%20%7C%2012-brightgreen?showLogo=Debian)
![Plutonium T5](https://img.shields.io/badge/Plutonium-T5-blue)
![License](https://img.shields.io/badge/License-GPL--3.0-yellow)
![GitHub repo size](https://img.shields.io/github/repo-size/Sterbweise/T5Server)
![GitHub stars](https://img.shields.io/github/stars/Sterbweise/T5Server)
![GitHub forks](https://img.shields.io/github/forks/Sterbweise/T5Server)
![GitHub issues](https://img.shields.io/github/issues/Sterbweise/T5Server)
![GitHub last commit](https://img.shields.io/github/last-commit/Sterbweise/T5Server)

<div style="display: flex; align-items: center;">
    <img src="https://github.com/user-attachments/assets/f7d88e45-2e01-4fe6-8834-6620eec4cf72" alt="image" width="400"/>
    <img src="https://imgur.com/bBrx8Hf.png" alt="Plutonium showLogo" width="400" style="margin-left: 10px;"/>
</div>


T5 Server is a comprehensive management suite for setting up and running Plutonium Call of Duty: Black Ops servers on Debian-based systems. This project aims to simplify the process of installing, configuring, and managing T5 servers, making it accessible to both beginners and experienced server administrators.


## Table of Contents
- [T5 Server - Plutonium Black Ops Server Installer](#t5-server---plutonium-black-ops-server-installer)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
    - [System Requirements](#system-requirements)
    - [Software Requirements](#software-requirements)
    - [Network Requirements](#network-requirements)
    - [Additional Considerations](#additional-considerations)
  - [Installation](#installation)
  - [Configuration](#configuration)
    - [Default Ports](#default-ports)
    - [Directory Structure](#directory-structure)
    - [File Organization](#file-organization)
      - [Custom Mods](#custom-mods)
  - [Launching the Server](#launching-the-server)
  - [Troubleshooting](#troubleshooting)
    - [Wine Display Errors](#wine-display-errors)
    - [Unable to Load Import from binkw32.dll](#unable-to-load-import-from-binkw32dll)
    - [Server Not Appearing in Plutonium Server List](#server-not-appearing-in-plutonium-server-list)
    - [Authentication Issues](#authentication-issues)
  - [Documentation](#documentation)
  - [Contributing](#contributing)
    - [Submitting Pull Requests](#submitting-pull-requests)
    - [Reporting Issues](#reporting-issues)
  - [License](#license)
  - [Acknowledgements](#acknowledgements)
  - [Support](#support)

## Features
- Easy installation and uninstallation process
- Automated system updates and dependency management 
- Firewall configuration and management with UFW
- Wine installation for Windows application support
- .NET Framework installation for IW4MAdmin support
- Multi-language support (English,French, Spanish and Chinese)
- MOD support with custom maps and game modes
- Detailed installation/uninstallation summaries

## Prerequisites

### System Requirements
- **Operating System:** Debian 10, 11, or 12 (64-bit)
- **Architecture:** x86_64 (AMD64)
- **RAM:** Minimum 512MB, 2GB recommended
- **Storage:** At least 15GB of free disk space

### Software Requirements
- **Root Access:** Full system privileges (root or sudo)
- **Package Manager:** apt (comes pre-installed on Debian)
- **Git:** For cloning the repository

If you don't have sudo or git installed, you can install them as follows:

1. To install sudo (as root):
   ```bash
   apt install sudo
   ```

2. To install git:
   ```bash
   sudo apt install git
   ```

These commands will ensure you have the necessary software to proceed with the installation.

### Network Requirements
- **Internet Connection:** Stable broadband connection
- **Firewall:** Ability to open and forward necessary ports
- **Static IP:** Recommended for consistent server accessibility

### Additional Considerations
- Basic familiarity with Linux command line
- Understanding of server administration concepts
- Willingness to troubleshoot potential issues

Ensure all prerequisites are met before proceeding with the installation to guarantee a smooth setup process.

## Installation

1. Navigate to the application installation directory:
   ```bash
   cd /opt
   ```

2. Download and extract T5Server archive in a single command:
   ```bash
   mkdir -p T5Server && wget -O T5Server.tar.gz https://github.com/Sterbweise/T5Server/releases/download/1.0.0/T5Server.tar.gz && tar -xzvf T5Server.tar.gz -C T5Server && rm T5Server.tar.gz
   ```

3. Move into the newly created T5Server directory:
   ```bash
   cd T5Server
   ```

4. Make the script executable:
   ```bash
   chmod +x install.sh
   ```

5. Launch the installation script with sudo privileges:
   ```bash
   sudo ./install.sh
   ```

6. Follow the on-screen instructions to complete the installation. The script will guide you through:
   - Language selection
   - UFW firewall installation and configuration
   - SSH port configuration
   - .NET installation (optional, required for IW4MAdmin)
   - Wine installation
   - Game binary installation

## Configuration

After installation, the primary configuration file to modify is `/opt/T5Server/T5Server.sh`. This file contains essential settings for your Plutonium Call of Duty: Black Ops II server. Below are the key variables you should configure:

| Variable    | Description                                           | Default Value              |
|-------------|-------------------------------------------------------|----------------------------|
| SERVER_NAME | The name of your server as it appears in server lists | "SERVER_NAME"              |
| GAME_PATH   | Path to your game files                               | "/opt/T5Server/Server" |
| SERVER_KEY  | Your unique Plutonium server key                      | "YOURKEY"                  |
| CONFIG_FILE | Server configuration file (mode-specific)             | "dedicated.cfg"            |
| SERVER_PORT | UDP port your server will listen on                   | 28961                       |
| GAME_MODE   | Game mode selection ("t5mp" or "t5sp")                | "t5mp"                     |
| MOD         | Path to your MOD directory (optional)                 | ""                         |

To configure your server:

1. Open the configuration file:
   ```bash
   nano /opt/T5Server/Plutonium/T5Server.sh
   ```

2. Modify the variables according to your preferences. For example:
   ```bash
   readonly SERVER_NAME="My Awesome T5 Server" # The name of your server
   readonly SERVER_KEY="your_server_key" # Key provided by Plutonium
   readonly SERVER_PORT=28961 # Default port for T5 servers
   readonly GAME_MODE="t5mp" # "t5mp" for Multiplayer, "t5sp" for Zombies
   readonly MOD="mods/weapons" # MOD path
   ```

3. Save the file and exit the editor by pressing `Ctrl+x`, then `Y` to confirm, and Enter to save.

Note: For Zombie mode, set `GAME_PATH` to "/opt/T5Server/Server/Zombie", `CONFIG_FILE` to "dedicated_zm.cfg", and `GAME_MODE` to "t6zm". Also, set the `MOD` variable to the path of the Zombie mode MOD.

Ensure all settings are correctly configured before launching your server.


### Default Ports
- T5 (Black Ops): 28961 (UDP)
  
### Directory Structure
| Directory | Path | Description |
|-----------|------|-------------|
| **Config** | `/opt/T5Server/Plutonium/storage/t5/` | Configuration files |
| **Mods** | `/opt/T5Server/Plutonium/storage/t5/mods/` | Custom game modifications |
| **Game Settings** | `/opt/T5Server/Plutonium/storage/t5/gamesettings/` | Game mode settings |
| **Player Data** | `/opt/T5Server/Plutonium/storage/t5/players/` | Player-specific data |
| **Scripts** | `/opt/T5Server/Plutonium/storage/t5/scripts/` | Custom game scripts |

To change maps:
1. Edit the appropriate configuration file:
   - Multiplayer: `/opt/T5Server/Plutonium/storage/t5/dedicated.cfg`
   - Zombie: `/opt/T5Server/Plutonium/storage/t5/dedicated_sp.cfg`

### File Organization
For proper server organization, place files in these specific directories:

#### Custom Mods
1. Place mod files in `/opt/T5Server/Plutonium/storage/t5/mods/`
2. Enable mods by adding to server config:
   ```bash
   readonly MOD="mods/zm_weapons"
   ```

## Launching the Server
To launch your Plutonium Call of Duty: Black Ops server, follow these professional steps:

1. Navigate to the T5Server installation directory:
   ```bash
   cd /opt/T5Server/Plutonium
   ```

2. Ensure the start script has the necessary execution permissions:
   ```bash
   sudo chmod +x T5Server.sh
   ```

3. Launch the server:
   ```bash
   ./T5Server.sh
   ```

For advanced server management:
- To run multiple servers concurrently, utilize terminal multiplexers such as `tmux` or `screen`.
- For background operation, you can use the `nohup` command:
  ```bash
  nohup ./T5Server.sh > server.log 2>&1 &
  ```
  This will run the server in the background, redirecting output to `server.log`.

Note: Ensure all necessary configurations in `server.cfg` and other relevant files are properly set before launching the server.

## Troubleshooting

This section provides solutions to common issues you may encounter while setting up and running your Plutonium Call of Duty: Black Ops II server. Follow these detailed steps to resolve problems efficiently.

### Wine Display Errors

**Issue**: You may see error messages related to Wine display when starting the server.

**Solution**: These errors are not critical and can be safely ignored. The Plutonium server operates as a console application and does not require graphical support. Your server will function correctly despite these messages.

**Note for debugging**: By default, Wine errors are hidden. If you need to debug Wine-related issues, you can remove the `2>/dev/null` at the end of the server start command in `T5Server.sh`. This will allow Wine errors to be displayed, which can be helpful for troubleshooting.

### Unable to Load Import from binkw32.dll

**Issue**: An error occurs when the server attempts to load binkw32.dll.

**Solution**: 
1. Verify the `GAME_PATH` variable in `T5Server.sh`:
   - Open the file: `nano /opt/T5Server/T5Server.sh`
   - Ensure the `GAME_PATH` variable is correctly set to your server's path, pointing to the directory containing binkw32.dll.

2. Correct file permissions:
   ```bash
   sudo chmod -R 755 /opt/T5Server
   ```

3. If the issue persists, try reinstalling the game binaries using the installation script.

### Server Not Appearing in Plutonium Server List

**Issue**: Your server is running but not visible to players in the Plutonium server list.

**Solution**:
1. Verify port accessibility:
   - Ensure the server port (default: 28961) is open for UDP traffic
   - Use a port checking tool to confirm the port is reachable from the internet
2. Configure your firewall:
   ```bash
   sudo ufw allow 28961/udp comment "Plutonium-Server"
   sudo ufw reload
   ```
3. If behind a NAT:
   - Configure port forwarding on your router
   - Forward UDP port 28961 to your server's local IP address
4. Verify server configuration:
   - Check `server.cfg` for correct settings
   - Ensure `sv_lanOnly` is set to 0

### Authentication Issues

**Issue**: You encounter authentication errors when starting the server.

**Solution**:
1. Verify your Plutonium key:
   - Log in to your Plutonium account at https://platform.plutonium.pw/serverkeys
   - Confirm your key is valid and not expired
2. Check key placement:
   - Open `T5Server.sh`
   - Ensure the `SERVER_KEY` variable contains your correct key
3. If issues persist:
   - Reinstall game binaries using the installation script
   - Update Plutonium to the latest version

For additional assistance, consult the [Plutonium forums](https://forum.plutonium.pw/) or join the [Plutonium Discord](https://discord.gg/plutonium) community.

## Documentation

For more detailed information on server configuration, configuration options, and advanced features, please refer to our [Wiki](https://github.com/Sterbweise/T5Server/wiki).

## Contributing
I appreciate contributions from the community! Here are some ways you can contribute to the T6 Server project:

### Submitting Pull Requests
1. Fork the repository and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. Ensure your code follows the existing style to maintain consistency.
4. Update the documentation if you've made changes that affect it.
5. Write a clear and descriptive commit message.
6. Open a pull request with a comprehensive description of the changes.

### Reporting Issues
- Use the GitHub issue tracker to report bugs
- Provide a clear and detailed description of the issue
- Include steps to reproduce the problem
- Specify your operating system and relevant software versions

## License
This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

I would like to express my sincere gratitude to the following projects and their creators for their invaluable contributions to the T6 Server project:

- [Plutonium](https://plutonium.pw): For their exceptional work on the T6 client and server, which forms the foundation of our project. Their dedication to preserving and enhancing classic Call of Duty titles is commendable.

- [IW4MAdmin](https://github.com/RaidMax/IW4M-Admin): I extend my thanks to RaidMax and the IW4MAdmin team for their comprehensive administration tools. Their robust solution significantly enhances server management capabilities.

- [plutonium-updater](https://github.com/mxve/plutonium-updater.rs): Special recognition goes to mxve for developing the plutonium-updater. This tool has been instrumental in streamlining our server update process, ensuring that our servers always run the latest version with minimal downtime.

These projects have been crucial in the development and ongoing improvement of T6 Server. I am deeply appreciative of the hard work and dedication of all contributors involved in these projects.

## Support

For support, please contact:

- Email: [contact@sterbweise.dev](mailto:contact@sterbweise.dev)
- Telegram: [@SG991](https://t.me/SG991)
- Discord: [Sterbweise](https://discord.com/users/sterbweise/)

You can also open an issue on this repository for bug reports or feature requests.

---

Developed with ❤️ by [Sterbweise](https://github.com/Sterbweise)
