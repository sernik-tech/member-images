#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install required build dependencies
dnf install -y git gzip python3-docutils

# Clone, build and install the effects
cd /tmp
git clone --single-branch --depth=1 https://github.com/foresto/joystickwake.git
cd joystickwake
python setup.py install --prefix=/usr --root=/tmp/joystickwake-built
