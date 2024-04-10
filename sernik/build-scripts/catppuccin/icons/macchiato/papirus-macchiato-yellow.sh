#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
FLAVOUR=macchiato
ACCENT=yellow

# Create icon directory
mkdir -p /usr/share/icons
mkdir -p /tmp/papirus/usr/share/icons

cd /tmp
# Install papirus manually via script
wget https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh
chmod +x install.sh
./install.sh

# Clone catppuccin papirus-folders
git clone https://github.com/catppuccin/papirus-folders.git
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-$FLAVOUR-$ACCENT
