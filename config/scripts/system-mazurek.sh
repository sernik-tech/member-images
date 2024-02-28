#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# add a few copr repos

# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
# swaylock
wget "https://copr.fedorainfracloud.org/coprs/vrumger/swaylock-effects/repo/fedora-$(rpm -E %fedora)/vrumger-swaylock-effects-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_vrumger-swaylock-effects.repo"

# bazzite packages
rpm-ostree install joystickwake xwiimote-ng

# swaylock effects
rpm-ostree override remove swaylock --install=swaylock-effects

# install power related utilities, ensuring no conflicts exist first
if rpm -qa | grep power-profiles-daemon ; then
    rpm-ostree override remove power-profiles-daemon --install=tlp --install=tlp-rdw --install=powertop
else
    rpm-ostree install tlp tlp-rdw powertop
fi

# enable sddm
#systemctl enable sddm

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/swayfx-swayfx-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/sneexy-swayland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_vrumger-swaylock-effects.repo
