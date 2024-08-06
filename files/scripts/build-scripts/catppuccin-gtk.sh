#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Originally, this script used the official catppuccin gtk repo, but that has since been archived.
# However, the theme it was based on, Colloid, includes catppuccin officially, so we just use that now.

# Create theme directory
mkdir -p /tmp/catppuccin-gtk/usr/etc/skel/.local/share/themes

# Dependencies to create theme
dnf install -y git sassc inkscape optipng gnome-themes-extra gtk-murrine-engine
cd /tmp
# Clone repository into /tmp/gtk
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
# Install theme
# NOTE: Specifying "catpuccin black" is mocha.
chmod +x install.sh
./install.sh -d /tmp/catppuccin-gtk/usr/share/themes -c dark -t green -s compact --tweaks catppuccin black
./install.sh -d /tmp/catppuccin-gtk/usr/share/themes -c light -t green -s compact --tweaks catppuccin
./install.sh -d /tmp/catppuccin-gtk/usr/etc/skel/.local/share/themes -c dark -t green -s compact --tweaks catppuccin black
./install.sh -d /tmp/catppuccin-gtk/usr/etc/skel/.local/share/themes -c light -t green -s compact --tweaks catppuccin
