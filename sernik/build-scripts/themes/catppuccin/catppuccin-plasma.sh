#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y git sed wget unzip

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
./install.sh 1 1 1
./install.sh 1 2 1
./install.sh 1 3 1
./install.sh 1 4 1
./install.sh 1 5 1
./install.sh 1 6 1
./install.sh 1 7 1
./install.sh 1 8 1
./install.sh 1 9 1
./install.sh 1 10 1
./install.sh 1 11 1
./install.sh 1 12 1
./install.sh 1 13 1
./install.sh 1 14 1
# Frappe
./install.sh 2 1 1
./install.sh 2 2 1
./install.sh 2 3 1
./install.sh 2 4 1
./install.sh 2 5 1
./install.sh 2 6 1
./install.sh 2 7 1
./install.sh 2 8 1
./install.sh 2 9 1
./install.sh 2 10 1
./install.sh 2 11 1
./install.sh 2 12 1
./install.sh 2 13 1
./install.sh 2 14 1
# Macchiato
./install.sh 3 1 1
./install.sh 3 2 1
./install.sh 3 3 1
./install.sh 3 4 1
./install.sh 3 5 1
./install.sh 3 6 1
./install.sh 3 7 1
./install.sh 3 8 1
./install.sh 3 9 1
./install.sh 3 10 1
./install.sh 3 11 1
./install.sh 3 12 1
./install.sh 3 13 1
./install.sh 3 14 1
# Mocha
./install.sh 4 1 1
./install.sh 4 2 1
./install.sh 4 3 1
./install.sh 4 4 1
./install.sh 4 5 1
./install.sh 4 6 1
./install.sh 4 7 1
./install.sh 4 8 1
./install.sh 4 9 1
./install.sh 4 10 1
./install.sh 4 11 1
./install.sh 4 12 1
./install.sh 4 13 1
./install.sh 4 14 1
