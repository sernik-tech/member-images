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

# remove default hyprland terminal
rpm-ostree override remove kitty

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tofik-nwg-shell-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:manuelschneid3r.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/peterwu-rendezvous-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

# create folder structure of the "skeleton" of user files
mkdir -p /etc/skel/.config
mkdir -p /etc/skel/.local

# clone dotfiles manually from repo and copy them to /etc/skel for user dotfiles
git clone https://git.gay/sneexy/mazurek-dots.git /tmp/dotfiles
cp -rf /tmp/dotfiles/config/* /etc/skel/.config
cp -rf /tmp/dotfiles/local/* /etc/skel/.local
