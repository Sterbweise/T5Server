
![alt text](https://img.shields.io/badge/Debian-10-red?logo=Debian)
![alt text](https://img.shields.io/badge/Debian-11-green?logo=Debian)
![alt text](https://img.shields.io/badge/Plutonium-T5-blue)

<img src="https://imgur.com/bBrx8Hf.png" alt="drawing" width="350"/> 

# T5Server
Simple installation and configuration of a T5 server on linux.

## Required
+ Last Version of Debian 10 (Work on Debian 11)
+ Storage more than 30Gb
+ Sudoer permission

## Installation
1. Download files : 
```shell 
git clone https://github.com/Minami-xan/T5Server.git
```
2. Move to `T5Server` Folder.
```shell
cd ~/T5Server/
```
3. Run the Installation Script `install.sh` .
```shell
sudo env "HOME=$HOME" bash install.sh
```
<center> <b>Installation Complete</b> </center>

## Configuration
1. Move to `Plutonium` Folder.
```shell
cd ~/T5Server/Plutonium/
```
2. Edit `T5_**_server.sh` with your information.
```shell
nano T5_mp_server.sh
#OR
nano T5_zm_server.sh
```
3. Allow server port.
```shell
sudo bash ~/T5Server/Scripts/allow_port.sh
```
<center> <b>Configuration Complete</b> </center>

## Launch Server
1. Move to `Plutonium` Folder.
```shell
cd ~/T5Server/Plutonium
```
2. Launch Server. 
```shell
./T5_mp_server.sh
#OR
./T5_zm_server.sh
```
   I advise you to use `tmux` or `screen` to open and manage multiple servers.

## Issues
### Wine display errors
   + Don't care of these errors, plutonium server doesn't have graphic support.

### Unable to load import '_BinkWaitStopAsyncThread@4' from module 'binkw32.dll'
   + Check your PAT variable in ./T5Server.sh. (It will be ping binkw32.dll dir)
   + Make sure to your user can read the file in all sub-dir of T5Server.

### Server don't appear in Plutonium Servers List
   + Check if your server port is open with UDP protocol. (Example: 4976)

### Connection with nix socket lost
   + Check your plutonium key validity
   + Check if your plutonium key are correctly write in T5Server.sh

### [DW][Auth] Handling authentication request
   + Check your plutonium key validity
   + Check if your plutonium key are correctly write in T5Server.sh

### Some problems with the downloading of the torrent file
   1. Delete Transmission config file ```shell rm -r ~/.config/transmission```
   2. Restart installtion ```shell sudo env "HOME=$HOME" bash install.sh```

## Source
• **Plutonium:** https://plutonium.pw <br>
• **My Topic** https://forum.plutonium.pw/topic/23683/guide-debian-t5-server-on-linux-vps-dedicated-server <br>
• **Plutonium-Updater by mxbe:** https://github.com/mxve/plutonium-updater.rs <br>
