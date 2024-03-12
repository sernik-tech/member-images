#!/usr/bin/env bash

set -oue pipefail

# This script installs all catpuccin related theming possible available. Currently does GTK, QT and Papirus-folders.
# All done during image creation time.

# Make a copy of this script for yourself if you want to modify the flavour and colors used.

# GTK Theme

# Install required dependencies. If you already layer these tools/utilities or need them then remove this
# and the uninstall part from your own copy of this script.
rpm-ostree install sassc inkscape optipng

# Clone the theme.
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk

# Create virtual environment and install required dependencies.
python3 -m venv /tmp/gtk
source /tmp/gtk/bin/activate
pip install -r requirements.txt

# Install the theme.
# Refer to https://github.com/catppuccin/gtk?tab=readme-ov-file#using-the-script
#                           {flavour}
#                           |        {accent}
#                           |        |
python3 /tmp/gtk/install.py mocha -a green -d /usr/share/themes
exit

# QT(5/6CT) Theme

# Clone the folder (A fork used with a fix as the original repo is inactive)
git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct

# Copy files to respective locations
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors

# Papirus Folders

# Clone the script
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
chmod +x /tmp/papirus-folders/papirus-folders

# Copy the contents to the system installed icons. because of this, we need to run
# this script AFTER installing the icons to ensure nothing goes wrong.
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus

# Change the color of the icon theme. You can find this... somehow?
# If you have a local copy, you can try running `papirus-folders -l`
# to see all colors.
#                                       {name of icon theme we want to change}
#                                       |               {name of the color scheme we want to set}
#                                       |               |
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

# Clean up.
rm -rf /tmp/gtk
rm -rf /tmp/qt6ct
rm -rf /tmp/papirus-folders

# Uninstall dependencies we installed earlier. Remove this line if you need these/already have these tools.
rpm-ostree remove sassc inkscape optipng
