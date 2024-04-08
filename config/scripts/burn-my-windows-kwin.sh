#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency
rpm-ostree install kf5-kwidgetsaddons-devel
#rpm-ostree install kf6-kwidgetsaddons-devel

# Clone git, build and install BMW's kwin effects
git clone https://github.com/Schneegans/Burn-My-Windows.git /tmp/bmw
chmod +x /tmp/bmw/kwin/build.sh
cd /tmp/bmw && /tmp/bmw/kwin/build.sh
tar -xf /tmp/bmw/kwin/burn_my_windows_kwin4.tar.gz -C /usr/share/kwin/effects

# Remove Dependency
rpm-ostree override remove kf5-kwidgetsaddons-devel
#rpm-ostree override remove kf6-kwidgetsaddons-devel
