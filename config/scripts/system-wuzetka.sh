#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

#
# Bazzite
#
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

#
# KDE Plasma 6
#
wget "https://copr.fedorainfracloud.org/coprs/solopasha/kde6/repo/fedora-$(rpm -E %fedora)/solopasha-kde6-fedora-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_solopasha-kde6.repo"

#                  {Bazzite packages}
#                  |                        {KDE Plasma 6 packages}
#                  |                        |
rpm-ostree install joystickwake xwiimote-ng plasma-desktop plasma-workspace plasma-wayland-protocols dolphin dolphin-plugins kate breeze-gtk merkuro

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_solopasha-kde6.repo
