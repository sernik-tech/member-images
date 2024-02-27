#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# adding copr repositories

# starship prompt
wget "https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-$(rpm -E %fedora)/atim-starship-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_atim-starship.repo"
# wezterm terminal
wget "https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-$(rpm -E %fedora)/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_wezfurlong-wezterm-nightly.repo"
# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# installing the packages

# install power related utilities, ensuring no conflicts exist first
if rpm -qa | grep power-profiles-daemon ; then
    rpm-ostree override remove power-profiles-daemon --install=tlp --install=tlp-rdw
else
    rpm-ostree install tlp tlp-rdw
fi

# console/terminal related packages
rpm-ostree install bat duf fastfetch fd-find fzf git-delta lsd neovim ripgrep sd starship zoxide zsh

# audio related packages
rpm-ostree install pavucontrol-qt playerctl

# terminal emulator(s)
rpm-ostree install kitty wezterm contour-terminal

# podman related packages
rpm-ostree install podman podman-compose podman-tui

# system libraries/configurations
rpm-ostree install fontconfig gnome-themes-extra lzip qt5-qtwayland qt6-qtwayland

# utilities
rpm-ostree install crontabs gamemode gamescope joystickwake mangohud xwiimote-ng

# enable any systemd services
systemctl enable tlp

# disabling the respositories for the booted system and later user packages (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_atim-starship.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_wezfurlong-wezterm-nightly.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
