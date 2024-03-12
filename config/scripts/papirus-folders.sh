#!/usr/bin/env bash

# Papirus-folders script done pre-setup because of how the script works that prevents it
# from working within a booted immutable environment.

# This is for the Catppuccin varient of the script, but should also work with the original script
# with small modifications.

# Make a copy of this script for yourself, as we have to modify/set the color of the icon theme during
# image creations as it still requires sudo to run.

# builds actually ran successfully without any errors!
set -oue pipefail

# clone the script
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
