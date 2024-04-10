#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# First set of packages are related to the backend, second set for pillow, the rest is related to the plasma widget
dnf install -y git python3-pip gcc plasma5support-devel kf6-kcoreaddons-devel kf6-kservice-devel python3-dbus dbus-python-devel glib2 glib2-devel \
    python3-devel redhat-rpm-config libtiff-devel libjpeg-devel openjpeg2-devel zlib-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel harfbuzz-devel fribidi-devel libraqm-devel libimagequant-devel libxcb-devel \
    extra-cmake-modules qt6-qttools-devel kf6-plasma-devel

# create build dir
mkdir -p /tmp/kde-material-you-built/usr

# Install the backend and other dependicies with pip
pip install --prefix=/tmp/kde-material-you-built/usr kde-material-you-colors
pip install --prefix=/tmp/kde-material-you-built/usr pywal

cd /tmp
git clone --single-branch --depth=1 https://github.com/luisbocanegra/kde-material-you-colors
cd kde-material-you-colors
cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/tmp/kde-material-you-built/usr -DINSTALL_PLASMOID=ON
cmake --build build
cmake --install build
