#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install required build dependencies
dnf install -y git gzip python3 python3-docutils

# dirs
mkdir -p /tmp/joystickwake-built/usr/share/man/man1

# Clone, build and install the effects
cd /tmp
git clone --single-branch --depth=1 https://github.com/foresto/joystickwake.git
cd joystickwake
python setup.py install --prefix=/usr --root=/tmp/joystickwake-built
rst2man README.rst joystickwake.1
gzip joystickwake.1
mv joystickwake.1.gz /tmp/joystickwake-built/usr/share/man/man1
