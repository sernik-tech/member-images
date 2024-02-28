#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/swayfx-swayfx-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/sneexy-swayland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_vrumger-swaylock-effects.repo
