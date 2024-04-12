#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# You'll need to install these packages in your image too (minus sassc)
dnf install -y git gnome-themes-extra gtk-murrine-engine sassc

# Create theme directory
mkdir -p /usr/share/themes
mkdir -p /tmp/colloid-gtk

cd /tmp
# Clone repository
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
chmod +x install.sh

./install.sh -t all -s standard -d /usr/share/themes
./install.sh -t all -s compact -d /usr/share/themes

# tweaks
#./install.sh -t all -s standard --tweaks all -d /usr/share/themes
./install.sh -t all -s standard --tweaks black -d /usr/share/themes
./install.sh -t all -s standard --tweaks rimless -d /usr/share/themes
./install.sh -t all -s standard --tweaks normal -d /usr/share/themes
./install.sh -t all -s standard --tweaks float -d /usr/share/themes
#./install.sh -t all -s compact --tweaks all -d /usr/share/themes
./install.sh -t all -s compact --tweaks black -d /usr/share/themes
./install.sh -t all -s compact --tweaks rimless -d /usr/share/themes
./install.sh -t all -s compact --tweaks normal -d /usr/share/themes
./install.sh -t all -s compact --tweaks float -d /usr/share/themes

# copy from /usr/share/icons, required due to symlinks
cp -r /usr/share/themes/* /tmp/colloid-gtk
