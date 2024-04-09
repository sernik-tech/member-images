#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install python3-pip if it's not already installed
if ! rpm -q python3-pip > /dev/null; then
    rpm-ostree install python3-pip
fi

# First set of packages are related to the backend, second set for pillow, the rest is related to the plasma widget
rpm-ostree install gcc python3-dbus dbus-python-devel glib2 glib2-devel \
    zlib zlib-devel libjpeg-turbo libjpeg-turbo-devel libtiff libtiff-devel lcms2 lcms2-devel libwebp libwebp-devel openjpeg2 openjpeg2-devel libimagequant libimagequant-devel libraqm libraqm-devel libxcb \
    extra-cmake-modules qt5-qttools-devel kf5-plasma-devel

# Install the backend and other dependicies with pip
pip install --prefix=/usr kde-material-you-colors
pip install --prefix=/usr pywal

git clone https://github.com/luisbocanegra/kde-material-you-colors -b plasma5 /tmp/kde-material-you
cd /tmp/kde-material-you && cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_PLASMOID=ON
cd /tmp/kde-material-you && cmake --build build
cd /tmp/kde-material-you && cmake --install build

# Remove
rpm-ostree install gcc dbus-python-devel glib2-devel \
    zlib-devel libjpeg-turbo-devel libtiff-devel lcms2-devel libwebp-devel openjpeg2-devel libimagequant-devel libraqm-devel libxcb-devel \
    extra-cmake-modules qt5-qttools-devel kf5-plasma-devel
