#!/bin/bash
## Update Region
echo -ne "[1/8] Set last version of your system [####                     ] (13%)                      \r"
{
apt update && apt upgrade -y
} > /dev/null 2>&1
## End Region

## Firewall Region
echo -ne "[2/8] Install firewall and allow 22 port [#######                  ] (25%)                      \r"
{
apt install ufw fail2ban -y && \
ufw allow 22/tcp && \
ufw default allow outgoing && \
ufw default deny incoming && \
ufw -f enable
} > /dev/null 2>&1
## End Region

# Enable 32 bit packages
echo -ne "[3/8] Enable 32 bit packages [###########              ] (38%)                      \r"
{
dpkg --add-architecture i386 && \
apt-get update -y && \
apt-get install wget gnupg2 software-properties-common apt-transport-https curl transmission-cli psmisc -y
} > /dev/null 2>&1

## Wine Region
echo -ne "[4/8] Installing Wine [##############           ] (50%)                      \r"
{
wget -nc https://dl.winehq.org/wine-builds/winehq.key
apt-key add winehq.key && \
apt-add-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main'
rm winehq.key
apt update -y
apt install --install-recommends winehq-stable -y

# Add Variables to the environment at the end of ~/.bashrc
echo -e 'export WINEPREFIX=~/.wine\nexport WINEDEBUG=fixme-all\nexport WINEARCH=win64' >> ~/.bashrc
echo -e 'export DISPLAY=:0' >> ~/.bashrc
source ~/.bashrc
winecfg
} > /dev/null 2>&1
## End Region

## Pre-Required for IW4MAdmin Region
echo -ne "[5/8] Installing Pre-Required for IW4MAdmin [#################        ] (63%)                      \r"
{
#Installation .NET Core 3.1
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#Install the SDK
#The .NET SDK allows you to develop apps with .NET. If you install the .NET SDK, you don't need to install the corresponding runtime. To install the .NET SDK, run the following commands:

apt-get update; \
	apt-get install -y dotnet-sdk-3.1
	apt-get install -y dotnet-sdk-6.0

#Install the runtime
#The ASP.NET Core Runtime allows you to run apps that were made with .NET that didn't provide the runtime. The following commands install the ASP.NET Core Runtime, which is the most compatible runtime for .NET. In your terminal, run the following commands:

apt-get update; \
	apt-get install -y aspnetcore-runtime-3.1
	apt-get install -y aspnetcore-runtime-6.0
} > /dev/null 2>&1
## End Region

echo -ne "[6/8] Game Binary Installation [####################     ] (75%)                      \r"
{
wget https://github.com/mxve/plutonium-updater.rs/releases/latest/download/plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
tar xfv plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
rm plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
chmod +x plutonium-updater
mv $HOME/T5Server/plutonium-updater $HOME/T5Server/Plutonium
} > /dev/null 2>&1

echo -ne "[7/8] Zones Files Installation [#######################  ] (88%)                      \r"
{
wget https://plutonium.pw/pluto_t5_full_game.torrent
tmpfile=$(mktemp)
chmod a+x $tmpfile
echo "killall transmission-cli" > $tmpfile
echo "rm $HOME/T5Server/pluto_t5_full_game.torrent" > $tmpfile
echo "mv $HOME/T5Server/pluto_t5_full_game $HOME/T5Server/Server" > $tmpfile
echo "rm -r $HOME/T5Server/Server/redist" > $tmpfile
} > /dev/null 2>&1
transmission-cli -f $tmpfile pluto_t5_full_game.torrent -w $HOME/T5Server

rm $HOME/T5Server/README.md
echo -ne "[8/8] Installation Complete [#########################] (100%)                      \n"