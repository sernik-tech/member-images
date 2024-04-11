#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install required build dependencies
dnf install -y git cmake extra-cmake-modules libplasma-devel plasma5support-devel

# dir
mkdir -p /tmp/panel-colorizer-built/usr

# Clone, build and install the effects
cd /tmp
git clone --single-branch --depth=1 https://github.com/luisbocanegra/plasma-panel-colorizer.git
cd plasma-panel-colorizer
cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/tmp/panel-colorizer-built/usr
cmake --build build
cmake --install build
