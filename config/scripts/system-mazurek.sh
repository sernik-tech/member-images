#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# add the swayfx and other related repositories

# swayfx
wget "https://copr.fedorainfracloud.org/coprs/swayfx/swayfx/repo/fedora-$(rpm -E %fedora)/swayfx-swayfx-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_swayfx-swayfx.repo"
# swayland repo
wget "https://copr.fedorainfracloud.org/coprs/sneexy/swayland/repo/fedora-$(rpm -E %fedora)/sneexy-swayland-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_sneexy-swayland.repo"
# bazzite repositories

# installing the packages

# install power related utilities, ensuring no conflicts exist first
if rpm -qa | grep power-profiles-daemon ; then
    rpm-ostree override remove power-profiles-daemon --install=tlp --install=tlp-rdw
else
    rpm-ostree install tlp tlp-rdw
fi

# console/terminal related packages
rpm-ostree install swayfx sway-audio-idle-inhibit

# disabling the respositories for the booted system and later user packages (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_atim-starship.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_wezfurlong-wezterm-nightly.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

# refer to system-wezetka to install the personal system packages
