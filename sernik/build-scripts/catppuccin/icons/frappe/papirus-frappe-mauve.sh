#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
FLAVOUR=frappe
ACCENT=mauve

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

# rename folder to allow multiple installs of the same theme
mv /usr/share/icons/Papirus-Dark /tmp/papirus/usr/share/icons/Papirus-${FLAVOUR^}-${ACCENT^}
