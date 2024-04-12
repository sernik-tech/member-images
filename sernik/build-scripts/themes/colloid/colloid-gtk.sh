#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# You'll need to install these packages in your image too (minus sassc)
dnf install -y git gnome-themes-extra gtk-murrine-engine sassc

# Create theme directory
mkdir -p /tmp/colloid-gtk

cd /tmp
# Clone repository
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
chmod +x install.sh

./install.sh -t all -s standard -d /tmp/colloid-gtk
./install.sh -t all -s compact -d /tmp/colloid-gtk

# tweaks
./install.sh -t all -s standard --tweaks all -d /tmp/colloid-gtk
./install.sh -t all -s standard --tweaks black -d /tmp/colloid-gtk
./install.sh -t all -s standard --tweaks rimless -d /tmp/colloid-gtk
./install.sh -t all -s standard --tweaks normal -d /tmp/colloid-gtk
./install.sh -t all -s standard --tweaks float -d /tmp/colloid-gtk
./install.sh -t all -s compact --tweaks all -d /tmp/colloid-gtk
./install.sh -t all -s compact --tweaks black -d /tmp/colloid-gtk
./install.sh -t all -s compact --tweaks rimless -d /tmp/colloid-gtk
./install.sh -t all -s compact --tweaks normal -d /tmp/colloid-gtk
./install.sh -t all -s compact --tweaks float -d /tmp/colloid-gtk
