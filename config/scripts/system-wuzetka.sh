#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

#
# Bazzite
#
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

# This script installs Catppuccin GTK, QT and Icon (Papirus) themes.
# Please copy this script and make your own modifications (folders, accent colors, flavours, etc.)
#
# This script is recommended to be ran after installing packages.
#
# Required packages (for the booted/installed system):
# papirus-icon-theme

# Set your flavours and colors.
# Refer to https://github.com/catppuccin/catppuccin#-palette
#
# Possible values:
#
# Flavours:
#
# latte
# frappe
# macchiato
# mocha
#
# Accent colors:
#
# rosewater
# flamingo
# pink
# mauve
# red
# maroon
# peach
# yellow
# green
# teal
# sky
# sapphire
# blue
# lavender
FLAVOUR=mocha
ACCENT_COLOR=green

# Ensure all required/used folders are created
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /etc/skel/.local/share/themes

#
# GTK Theme
#

# Install dependencies
# Only required for creating the GTK theme, if you use any of these packages for your system and/or preinstall them,
# remove installing and uninstalling the packages you use from this script
rpm-ostree install sassc inkscape optipng

git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk # Clone the GTK theme repository
python3 -m venv /tmp/gtk # Create python virtual environment
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt # Install python dependencies within the virtual environment
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /usr/share/themes # Install the theme system-side (May not be required for your own use-case)
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /etc/skel/.local/share/themes # Install the theme for users (only for fresh installs and new users)
# NOTE: You can specify `-s compact` for a more compact version of the GTK theme to be installed.
# For example: python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /usr/share/themes

#
# KDE Theme
#

#git clone https://github.com/catppuccin/kde.git /tmp/kde # Clone the KDE theme repository
#cd /tmp/kde && git checkout v0.2.5 # Only for KDE Plasma 5. Remove this line when we get bumped to Plasma 6
#sed -i 's@${XDG_DATA_HOME:-$HOME/.local/share}/color-schemes@/etc/skel/.local/share/color-schemes@g' /tmp/kde/install.sh # Replace the directories in the script to the proper skeleton directory
#sed -i 's@${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes@/etc/skel/.local/share/aurorae/themes@g' /tmp/kde/install.sh
#sed -i 's@${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel@/etc/skel/.local/share/plasma/look-and-feel@g' /tmp/kde/install.sh
#sed -i 's@${XDG_DATA_HOME:-$HOME/.local/share}/icons@/etc/skel/.local/share/icons@g' /tmp/kde/install.sh
#chmod +x /tmp/kde/install.sh # Make sure its executable
#yes | /tmp/kde/install.sh 1 9 1

#
# Papirus (Folders)
#

# Clone the script & copy the contents to the installed icons.
# Reminder: This means that this script has to run after installing packages.
# Make sure you are installing the `papirus-icon-theme` package.
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus # Copy the custom files to Papirus
chmod +x /tmp/papirus-folders/papirus-folders # Making the script executable
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-${FLAVOUR}-${ACCENT_COLOR} # Change the color of the icon theme using papirus-folders

#
# Clean up
#

rm -rf /tmp/gtk
#rm -rf /tmp/kde
rm -rf /tmp/papirus-folders
rpm-ostree override remove sassc inkscape optipng
