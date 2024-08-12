#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install required build dependencies
dnf install -y git gzip python3 python3-docutils

# dirs
mkdir -p /tmp/joystickwake-built/usr/share/man/man1
mkdir -p /tmp/joystickwake-built/usr/bin
mkdir -p /tmp/joystickwake-built/etc/xdg/autostart

# Clone, build and install the effects
cd /tmp
git clone --single-branch --depth=1 https://github.com/foresto/joystickwake.git
cd joystickwake
chmod +x joystickwake
chmod +x joystickwake.desktop
mv joystickwake /tmp/joystickwake-built/usr/bin
mv joystickwake.desktop /tmp/joystickwake-built/etc/xdg/autostart
rst2man README.rst joystickwake.1
gzip joystickwake.1
mv joystickwake.1.gz /tmp/joystickwake-built/usr/share/man/man1
