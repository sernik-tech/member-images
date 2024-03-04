#!/usr/bin/env bash

# Papirus-folders script done pre-setup because of how the script works that prevents it
# from working within a booted immutable environment.

# This is for the Catppuccin varient of the script.

# builds actually ran successfully without any errors!
set -oue pipefail

# clone the script
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders

# Copy the contents to the system installed icons. because of this, we need to run
# this script AFTER installing the icons to ensure nothing goes wrong.
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus

# Copy the script to /usr/bin/ so the user can change the theme themselves.
cp /tmp/papirus-folders/papirus-folders /usr/bin
