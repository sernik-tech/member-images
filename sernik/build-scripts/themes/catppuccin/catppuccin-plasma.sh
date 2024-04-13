#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y gettext-devel git sed wget unzip

# dirs
mkdir -p /tmp/catppuccin-kde/usr/share/color-schemes
mkdir -p /tmp/catppuccin-kde/usr/share/aurorae/themes
mkdir -p /tmp/catppuccin-kde/usr/share/plasma/look-and-feel
mkdir -p /tmp/catppuccin-kde/usr/share/icons

# KDE Theme
cd /tmp
git clone https://github.com/catppuccin/kde.git
cd kde
rm -f install.sh
curl -sL -o install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/sernik/build-scripts/themes/catppuccin/catppuccin-plasma-install.sh
chmod +x install.sh
# Latte
./install.sh 1 9 1
# Mocha
./install.sh 4 9 1
