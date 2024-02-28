#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# add the swayfx and other related repositories

# swayfx
wget "https://copr.fedorainfracloud.org/coprs/swayfx/swayfx/repo/fedora-$(rpm -E %fedora)/swayfx-swayfx-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_swayfx-swayfx.repo"
# swayland repo
wget "https://copr.fedorainfracloud.org/coprs/sneexy/swayland/repo/fedora-$(rpm -E %fedora)/sneexy-swayland-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_sneexy-swayland.repo"
# bazzite repositories

# managing the packages

# removing base packages
rpm-ostree override remove sway

# swayfx and friends
rpm-ostree install swayfx sway-audio-idle-inhibit

# disabling the respositories for the booted system and later user packages (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_swayfx-swayfx.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_sneexy-swayland.repo

# refer to system-wezetka to install the personal system packages
