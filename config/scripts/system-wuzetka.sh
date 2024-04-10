#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Bazzite
#wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
#wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# bazzite packages
#rpm-ostree install joystickwake xwiimote-ng

# systemd services to enable on the system
systemctl enable hblock.timer

# Ensure all required/used folders are created
mkdir -p /usr/share/sddm/themes
#mkdir -p /usr/share/plasma/plasmoids/org.kde.latte.spacer

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
# KDE Theme
#
git clone https://github.com/catppuccin/kde.git /tmp/catppuccinkde
cd /tmp/catppuccinkde && git checkout v0.2.5 # Comment when Fedora 40/Plasma 6
rm -f /tmp/catppuccinkde/install.sh
#curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/config/scripts/catppuccin-plasma6.sh
curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/config/scripts/catppuccin-plasma5.sh # Comment when Fedora 40/Plasma 6
chmod +x /tmp/catppuccinkde/install.sh
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1 # Mocha Green (dark)
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1 # Latte Green (light)

#
# SDDM Theme
#
git clone https://github.com/aczw/sddm-theme-corners.git /tmp/corners
sudo cp -r /tmp/corners/corners /usr/share/sddm/themes

#
# Latte spacer
#
#git clone https://github.com/psifidotos/applet-latte-spacer.git /tmp/latte-spacer
# plasma 6 git, might be unneeded later
#git clone https://github.com/doncsugar/applet-latte-spacer.git /tmp/latte-spacer
#rm -rf /tmp/latte-spacer/.git
#rm -f /tmp/latte-spacer/README.md
#rm -f /tmp/latte-spacer/CHANGELOG.md
#cp -r /tmp/latte-spacer/* /usr/share/plasma/plasmoids/org.kde.latte.spacer

#
# Panel Colorizer
#
rpm-ostree install libplasma plasma5support
git clone git clone https://github.com/luisbocanegra/plasma-panel-colorizer /tmp/panel-colorizer
cd /tmp/panel-colorizer && cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr
cd /tmp/panel-colorizer && cmake --build build
cd /tmp/panel-colorizer && cmake --install build

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
