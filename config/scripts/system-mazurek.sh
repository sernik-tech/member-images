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

# remove kitty terminal (needs to be done here because its after hyprland is installed)
rpm-ostree override remove kitty

#
# create all required folders for the following setup
#
mkdir -p /etc/mazurek
mkdir -p /etc/skel/.config/nvim
mkdir -p /etc/skel/.local/share/icons
mkdir -p /usr/share/backgrounds/catppuccin

#
# NvChad
#

# clone the starting repo into the proper location of user's files
git clone https://github.com/NvChad/starter.git /etc/skel/.config/nvim

#
# Dotfiles
#

# clone dotfiles manually from repo and copy them to /etc/skel for user dotfiles
git clone https://git.gay/sneexy/mazurek-dots.git /tmp/dotfiles
cp -rf /tmp/dotfiles/config/* /etc/skel/.config
cp -rf /tmp/dotfiles/local/* /etc/skel/.local
cp -rf /tmp/dotfiles/icons/* /etc/skel/.local/share/icons
cp -rf /tmp/dotfiles/wallpapers/mazurek-catppuccin/* /usr/share/backgrounds/catppuccin

# ensure bins are executable
chmod +x /etc/skel/.local/bin/*

#
# Clean up
#
rm -rf /tmp/dotfiles

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tofik-nwg-shell-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:manuelschneid3r.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/peterwu-rendezvous-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
