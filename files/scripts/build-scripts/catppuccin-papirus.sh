#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Create theme directory
mkdir -p /tmp/catppuccin-papirus/usr/share/icons

# Dependencies
dnf install -y git python3 python3-pip python3-gobject gtk3
pip install --prefix=/usr colormath tqdm pillow
cd /tmp
# Clone repository into /tmp/Color-manager
git clone https://github.com/NicklasVraa/Color-manager
cd Color-manager
# Python setup
python3 -m venv venv # Create python virtual environment
source venv/bin/activate
pip install -r requirements.txt
# Create theme and install
# As user:
python3 install.py latte -a green -s compact -d /tmp/catppuccin-papirus/usr/share/icons
python3 install.py mocha -a green -s compact -d /tmp/catppuccin-papirus/usr/share/icons