#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
FLAVOUR=mocha
ACCENT=green

if [ ! "rpm -qa | grep papirus-icon-theme" ]; then
    rpm-ostree install papirus-icon-theme
fi

git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-$FLAVOUR-$ACCENT
