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

#
# KDE Theme
#
git clone https://github.com/catppuccin/kde.git /tmp/catppuccinkde
rm -f /tmp/catppuccinkde/install.sh
curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/sernik/scripts/catppuccin-plasma.sh
chmod +x /tmp/catppuccinkde/install.sh
# Latte
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1
# Mocha
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1

#
# Papirus-folders
#
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Light -C cat-latte-green
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

#
# Papirus KDE Colored Icons
#
git clone https://github.com/luisbocanegra/papirus-colors.git /tmp/papirus-colors
sed -i 's@~/.local/share/icons/@/usr/share/icons@g' /tmp/papirus-colors/places_icons_mod.sh
chmod +x /tmp/papirus-colors/places_icons_mod.sh
cd /tmp/papirus-colors && /tmp/papirus-colors/places_icons_mod.sh

#
# Wuzetka Desktop Layouts
#
git clone https://git.gay/sneexy/sernik.git /tmp/wuzetka
cp -r /tmp/wuzetka/kde/wuzetka* /usr/share/plasma/look-and-feel

#
# Justfiles
#
wget "https://raw.githubusercontent.com/ublue-os/bazzite/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-waydroid.just" -O "/usr/share/ublue-os/just/31-waydroid.just"
wget "https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just" -O "/usr/share/ublue-os/just/62-bazzite-fixes.just"
wget "https://raw.githubusercontent.com/ublue-os/bazzite/main/system_files/desktop/shared/usr/share/ublue-os/just/83-bazzite-audio.just" -O "/usr/share/ublue-os/just/41-audio.just"
