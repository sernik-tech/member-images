#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y git wget sed papirus-icon-theme

# dirs
mkdir -p /tmp/colloid-icons/usr/share/icons

cd /tmp

# grab colloid
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
chmod +x install.sh

./install.sh -s all -t all -d /tmp/colloid-icons/usr/share/icons
