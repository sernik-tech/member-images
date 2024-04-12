#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y gettext-devel git sed wget unzip

# dirs
mkdir -p /tmp/colloid-kde/usr/share/aurorae/themes
mkdir -p /tmp/colloid-kde/usr/share/color-schemes
mkdir -p /tmp/colloid-kde/usr/share/plasma/desktoptheme
mkdir -p /tmp/colloid-kde/usr/share/plasma/look-and-feel
mkdir -p /tmp/colloid-kde/usr/share/Kvantum
mkdir -p /tmp/colloid-kde/usr/share/wallpapers

# KDE Theme
cd /tmp
git clone https://github.com/vinceliuice/Colloid-kde.git
cd Colloid-kde
sed -i 's@/usr/share/@/tmp/colloid-kde/usr/share/@g' install.sh
sed -i 's@$HOME/.local/share/@/tmp/colloid-kde/usr/share/@g' install.sh
chmod +x install.sh

./install.sh
