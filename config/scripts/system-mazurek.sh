#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# adding copr repositories

# swayfx
wget "https://copr.fedorainfracloud.org/coprs/swayfx/swayfx/repo/fedora-$(rpm -E %fedora)/swayfx-swayfx-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_swayfx-swayfx.repo"
# swayland repo
wget "https://copr.fedorainfracloud.org/coprs/sneexy/swayland/repo/fedora-$(rpm -E %fedora)/sneexy-swayland-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_sneexy-swayland.repo"
# starship prompt
wget "https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-$(rpm -E %fedora)/atim-starship-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_atim-starship.repo"
# wezterm terminal
wget "https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-$(rpm -E %fedora)/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_wezfurlong-wezterm-nightly.repo"
# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
# bibata cursors
wget "https://copr.fedorainfracloud.org/coprs/peterwu/rendezvous/repo/fedora-$(rpm -E %fedora)/peterwu-rendezvous-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_peterwu-rendezvous.repo"
# rom properties
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/rom-properties/repo/fedora-$(rpm -E %fedora)/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-rom-properties.repo"

# managing the packages

# display manager
rpm-ostree install sddm

# environment
rpm-ostree install xorg-x11-server-Xwayland polkit lxpolkit xdg-user-dirs dbus-tools dbus-daemon wl-clipboard gnome-keyring pavucontrol playerctl qt5-qtwayland qt6-qtwayland vulkan-validation-layers vulkan-tools google-noto-emoji-fonts gnome-disk-utility fontconfig lzip gnome-themes-extra

# audio
rpm-ostree install wireplumber pipewire pamixer

# networking & bluetooth
rpm-ostree install network-manager-applet NetworkManager-openvpn NetworkManager-openconnect bluez bluez-tools blueman

# utilities
rpm-ostree install bat duf fastfetch fd-find fzf git-delta lsd neovim ripgrep sd starship zoxide zsh crontabs gamemode gamescope joystickwake mangohud xwiimote-ng slurp grim flameshot qt5-qtgraphicaleffects qt5-qtquickcontrols2 qt5-qtsvg

# themes
rpm-ostree plasma-breeze bibata-cursor-themes gnome-themes-extra papirus-icon-theme qt5ct qt6ct

# display
rpm-ostree install wlr-randr wlsunset grimshot light kanshi

# applications

# terminal emulators
rpm-ostree install kitty wezterm contour-terminal qt5-qtgraphicaleffects

# podman
rpm-ostree install podman podman-compose podman-tui

# applications
rpm-ostree install xarchiver imv p7zip unrar-free mpv

# swayfx and friends
rpm-ostree install swayfx sway-audio-idle-inhibit

# install power related utilities, ensuring no conflicts exist first
if rpm -qa | grep power-profiles-daemon ; then
    rpm-ostree override remove power-profiles-daemon --install=tlp --install=tlp-rdw --install=powertop
else
    rpm-ostree install tlp tlp-rdw powertop
fi

# disabling the respositories for the booted system and later user packages (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_swayfx-swayfx.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_sneexy-swayland.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_atim-starship.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_wezfurlong-wezterm-nightly.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_peterwu-rendezvous.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-rom-properties.repo

