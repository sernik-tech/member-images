#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
GTKDIR=/tmp/catppuccin-gtk

# Create theme directory
mkdir -p $GTKDIR

# Dependencies to create theme
dnf install -y sassc inkscape optipng
cd /tmp
# Clone repository into /tmp/gtk
git clone --recurse-submodules https://github.com/catppuccin/gtk.git
cd gtk
# Python setup
python3 -m venv venv # Create python virtual environment
source venv/bin/activate
pip install -r requirements.txt
# Create theme and install to user directory
python3 install.py all -a all -d $GTKDIR
python3 install.py all -a all -s compact -d $GTKDIR
