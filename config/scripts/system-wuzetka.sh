#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

#
# Extra Packages
#

# adding bazzite packages

# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# utilities
rpm-ostree install joystickwake xwiimote-ng

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

#
# KDE Effects
#

# KDE Rounded Corners - https://github.com/matinlotfali/KDE-Rounded-Corners

# NOTE: You need to change this for plasma 6
# Install development packages & ensure correct paths are exported
#rpm-ostree install binutils cmake gcc-c++ extra-cmake-modules kwin-devel kf5-kconfigwidgets-devel libepoxy-devel
#export PATH=$PATH:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin

# Clone repo and compile & install effects
#git clone https://github.com/matinlotfali/KDE-Rounded-Corners /tmp/rounded-corners
#mkdir -p /tmp/rounded-corners/build
#cd /tmp/rounded-corners/build && cmake .. --install-prefix /usr
#cd /tmp/rounded-corners/build && make
#cd /tmp/rounded-corners/build && make install

# Remove development packages & Clean up
#rpm-ostree override remove cmake gcc-c++ extra-cmake-modules kwin-devel kf5-kconfigwidgets-devel libepoxy-devel
#rm -rf /tmp/rounded-corners
