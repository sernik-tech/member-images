#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# bazzite repositories and packages
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
rpm-ostree install joystickwake xwiimote-ng

mkdir -p /etc/skel/.local/share/themes
mkdir -p /usr/share/Kvantum

# adw-gtk3
wget "$(curl -sL https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest| jq -r '.assets[] | select(.name? | match("adw-gtk3v.*.tar.xz$")) | .browser_download_url')" -O /tmp/adw-gtk3.tar.xz
tar -xvf /tmp/adw-gtk3.tar.xz -C /etc/skel/.local/share/themes

# KvLibadwaita
git clone https://github.com/GabePoel/KvLibadwaita.git /tmp/adw-qt # Clone repo
cp -r /tmp/adw-qt/src/* /usr/share/Kvantum

# pywal
# if ! rpm -q python3-pip > /dev/null; then
#     rpm-ostree install python3-pip
# fi
# pip install --prefix=/usr pywal

# i don't think this is necessary but do it anyways i guess
rm -rf /tmp/adw-gtk3.tar.xz
rm -rf /tmp/adw-qt
