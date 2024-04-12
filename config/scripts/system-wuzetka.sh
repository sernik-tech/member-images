#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# systemd services to enable on the system
systemctl enable hblock.timer

# Ensure all required/used folders are created
mkdir -p /usr/share/sddm/themes

#
# Sheldon
#
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to /usr/bin

#
# Krabby
#
KRABBY_VER=$(curl -sL https://api.github.com/repos/yannjor/krabby/releases/latest | jq -r '.assets[] | select(.name? | match("krabby-.*-x86_64.tar.gz$")) | .browser_download_url')
curl -sL -o /tmp/krabby.tar.gz ${KRABBY_VER}
tar -xvf /tmp/krabby.tar.gz -C /tmp
cp /tmp/krabby /usr/bin
chmod +x /usr/bin/krabby

#
# wgcf
#
WGCF_VER=$(curl -sL https://api.github.com/repos/ViRb3/wgcf/releases/latest | jq -r '.assets[] | select(.name? | match("wgcf_.*_linux_amd64$")) | .browser_download_url')
curl -sL -o /usr/bin/wgcf ${WGCF_VER}
chmod +x /usr/bin/wgcf

#
# OpenTabletDriver
#
curl -sL -o /tmp/otd.rpm https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver.rpm
rpm-ostree install /tmp/otd.rpm

#
# KDE Theme
#
#git clone https://github.com/catppuccin/kde.git /tmp/catppuccinkde
#cd /tmp/catppuccinkde && git checkout v0.2.5 # Comment when Fedora 40/Plasma 6
#rm -f /tmp/catppuccinkde/install.sh
#curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/config/scripts/catppuccin-plasma6.sh
#curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/config/scripts/catppuccin-plasma5.sh # Comment when Fedora 40/Plasma 6
#chmod +x /tmp/catppuccinkde/install.sh
#cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1 # Mocha Green (dark)
#cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1 # Latte Green (light)

#
# SDDM Theme
#
git clone https://github.com/catppuccin/sddm.git /tmp/catppuccin-sddm
cp -r /tmp/catppuccin-sddm/src /usr/share/sddm/themes
mv /usr/share/sddm/themes/src /usr/share/sddm/themes/catppuccin-mocha
cp /tmp/catppuccin-sddm/pertheme/mocha.conf /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@Font="Noto Sans"@Font="Lexend Deca"@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@FontSize=9@FontSize=11@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@# PasswordShowLastLetter=1000@PasswordShowLastLetter=1000@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@Font="Noto Sans"@Font="Lexend Deca"@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf

# Papirus KDE Colored Icons
git clone https://github.com/luisbocanegra/papirus-colors.git /tmp/papirus-colors
sed -i 's@~/.local/share/icons/@/usr/share/icons@g' /tmp/papirus-colors/places_icons_mod.sh
chmod +x /tmp/papirus-colors/places_icons_mod.sh
cd /tmp/papirus-colors && /tmp/papirus-colors/places_icons_mod.sh
