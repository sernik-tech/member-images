#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# bazzite repositories and packages
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
rpm-ostree install joystickwake xwiimote-ng

mkdir -p /usr/share/Kvantum
mkdir -p /usr/share/qt5ct/colors
mkdir -p /usr/share/qt6ct/colors
mkdir -p /usr/share/icons
mkdir -p /etc/skel/.local/share/themes

# adw-gtk3
#wget "$(curl -sL https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest| jq -r '.assets[] | select(.name? | match("adw-gtk3v.*.tar.xz$")) | .browser_download_url')" -O /tmp/adw-gtk3.tar.xz
#tar -xvf /tmp/adw-gtk3.tar.xz -C /etc/skel/.local/share/themes

# KvLibadwaita
#git clone https://github.com/GabePoel/KvLibadwaita.git /tmp/adw-qt # Clone repo
#cp -r /tmp/adw-qt/src/* /usr/share/Kvantum

# pywal
# if ! rpm -q python3-pip > /dev/null; then
#     rpm-ostree install python3-pip
# fi
# pip install --prefix=/usr pywal

# i don't think this is necessary but do it anyways i guess
#rm -rf /tmp/adw-gtk3.tar.xz
#rm -rf /tmp/adw-qt

# Catppuccin GTK Theme
rpm-ostree install sassc inkscape optipng
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk # Clone the GTK theme repository
python3 -m venv /tmp/gtk/venv
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact --tweaks floating -d /etc/skel/.local/share/themes

# Catppuccin QT(5/6CT) Theme
git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors

# Papirus (Folders)
# remember you need the package to be installed
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
