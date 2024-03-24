#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# add a few copr repos

# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# bazzite packages
rpm-ostree install joystickwake xwiimote-ng

#
# create all required folders for the following setup
#

mkdir -p /etc/skel/.local/share/themes
mkdir -p /usr/share/Kvantum
mkdir -p /usr/share/backgrounds/catppuccin

#
# adw-gtk3
#

wget "$(curl -sL https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest| jq -r '.assets[] | select(.name? | match("adw-gtk3v.*.tar.xz$")) | .browser_download_url')" -O /tmp/adw-gtk3.tar.xz # Install adw-gtk3 theme (Non-flatpak)
tar -xvf /tmp/adw-gtk3.tar.xz -C /etc/skel/.local/share/themes

#
# KvLibadwaita
#

git clone https://github.com/GabePoel/KvLibadwaita.git /tmp/adw-qt # Clone repo
cp -r /tmp/adw-qt/src/* /usr/share/Kvantum

#
# pywal
#

# Install python3-pip if it's not already installed
if ! rpm -q python3-pip > /dev/null; then
    rpm-ostree install python3-pip
fi

pip install --prefix=/usr pywal # Install pywal via pip, as its the only available method to install it on Fedora

#
# Clean up
#
rm -rf /tmp/adw-gtk3.tar.xz
rm -rf /tmp/adw-qt

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
