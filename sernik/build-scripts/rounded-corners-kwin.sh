#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install required build dependencies
dnf install -y git cmake gcc-c++ extra-cmake-modules kwin-devel kf6-kconfigwidgets-devel libepoxy-devel kf6-kcmutils-devel qt6-qtbase-private-devel wayland-devel

# Clone, build and install the effects
git clone --single-branch --depth=1 https://github.com/matinlotfali/KDE-Rounded-Corners.git
cd KDE-Rounded-Corners
mkdir build
cd build
cmake .. --install-prefix /usr
make
make install DESTDIR=/tmp/rounded-corners-built PREFIX='/usr'
