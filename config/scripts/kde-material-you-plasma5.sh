#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install python3-pip if it's not already installed
if ! rpm -q python3-pip > /dev/null; then
    rpm-ostree install python3-pip
fi

# Install the backend and other dependicies with pip
pip install --prefix=/usr kde-material-you-colors
pip install --prefix=/usr pywal

# First 4 deps are related to the backend, the rest is related to the plasma widget
rpm-ostree install gcc dbus-python-devel glib2-devel python3-pillow extra-cmake-modules qt5-qttools-devel kf5-plasma-devel

git clone https://github.com/luisbocanegra/kde-material-you-colors /tmp/kde-material-you
cd /tmp/kde-material-you && git checkout plasma5
cd /tmp/kde-material-you && cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_PLASMOID=ON
cd /tmp/kde-material-you && cmake --build build
cd /tmp/kde-material-you && cmake --install build

# Remove
rpm-ostree install gcc dbus-python-devel glib2-devel extra-cmake-modules qt5-qttools-devel kf5-plasma-devel
