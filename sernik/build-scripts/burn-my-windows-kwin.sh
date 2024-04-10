#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency
dnf install -y git gettext kf6-kwidgetsaddons-devel

# Create kwin effect's folder
mkdir -p /tmp/burn-my-windows-built/usr/share/kwin/effects

# Clone git, build and install BMW's kwin effects
cd /tmp
git clone --single-branch --depth=1 https://github.com/Schneegans/Burn-My-Windows.git
cd Burn-My-Windows/kwin
chmod +x build.sh
/tmp/Burn-My-Windows/kwin/build.sh
tar -xf burn_my_windows_kwin4.tar.gz -C /tmp/burn-my-windows-built/usr/share/kwin/effects
