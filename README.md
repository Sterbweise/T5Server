
![alt text](https://img.shields.io/badge/Debian-10-red?logo=Debian)
![alt text](https://img.shields.io/badge/Plutonium-T5-blue)

<img src="https://imgur.com/bBrx8Hf.png" alt="drawing" width="350"/> <img src="https://i.imgur.com/TdpsBgH.png" alt="drawing" width="200"/>

# T5Server
All files needed for a simple installation and configuration of a T5 server on linux.

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
sudo bash install.sh
```
4. Move Plutonium updater
```shell
mv ~/T6Server/plutonium-updater ~/T6Server/Plutonium/
```
5. Move Zone file to Server directory
```shell
mv ~/T6Server/zone ~/T6Server/Server/zone
```
6. Make file executable `T5Server.sh`.
```shell
chmod +x ~/T5Server/Plutonium/T5Server.sh
```

7. **Installation Complete**

## Configuration
1. Move to `Plutonium` Folder.
```shell
cd ~/T5Server/Plutonium/
```
2. Edit `T5Server.sh` with your information.
```shell
nano T5Server.sh
```
3. Allow server port.
```shell
sudo bash ~/T5Server/Scripts/allow_port.sh
```
**Configuration Complete**

## Launch Server
1. Move to `Plutonium` Folder.
```shell
cd ~/T5Server/Plutonium
```
2. Launch Server. 
```shell
./T5Server.sh
```
   I advise you to use `tmux` or `screen` to open and manage multiple servers.


## Source
• **Plutonium:** https://plutonium.pw <br>
• **IW4MAdmin by RaidMax:** https://github.com/RaidMax/IW4M-Admin <br>
• **Plutonium-Updater by mxbe:** https://github.com/mxve/plutonium-updater.rs <br>