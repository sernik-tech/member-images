#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install python3-pip if it's not already installed
if ! rpm -q python3-pip > /dev/null; then
    rpm-ostree install python3-pip
fi

# First set of packages are related to the backend, second set for pillow, the rest is related to the plasma widget
rpm-ostree install gcc python3-dbus dbus-python-devel glib2 glib2-devel \
    python3-devel redhat-rpm-config libtiff-devel libjpeg-devel openjpeg2-devel zlib-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel harfbuzz-devel fribidi-devel libraqm-devel libimagequant-devel libxcb-devel \
    extra-cmake-modules qt5-qttools-devel kf5-plasma-devel

# Install the backend and other dependicies with pip
pip install --prefix=/usr kde-material-you-colors==1.7.1
pip install --prefix=/usr pywal

git clone https://github.com/luisbocanegra/kde-material-you-colors -b plasma5 /tmp/kde-material-you
cd /tmp/kde-material-you && cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_PLASMOID=ON
cd /tmp/kde-material-you && cmake --build build
cd /tmp/kde-material-you && cmake --install build

# Remove
rpm-ostree override remove annobin-docs annobin-plugin-gcc ansible-srpm-macros brotli-devel bzip2-devel clang-libs clang-resource-filesystem cmake cmake-data compiler-rt dbus-python-devel dbus-devel efi-srpm-macros extra-cmake-modules fontconfig-devel fonts-srpm-macros forge-srpm-macros fpc-srpm-macros freetype-devel fribidi-devel gcc-plugin-annobin ghc-srpm-macros glib2-devel gnat-srpm-macros go-srpm-macros graphite2-devel harfbuzz-devel harfbuzz-icu jsoncpp kernel-srpm-macros kf5-kconfig kf5-kconfig-devel kf5-kcoreaddons-devel kf5-kpackage-devel kf5-kservice-devel kf5-kwindowsystem-devel kf5-plasma-devel kf5-rpm-macros lcms2-devel libX11-devel libXau-devel libXft-devel libXrender-devel libatomic libblkid-devel libffi-devel libglvnd-core-devel libglvnd-devel libicu-devel libimagequant-devel libjpeg-turbo-devel libmount-devel libomp libomp-devel libpng-devel libraqm-devel libselinux-devel libsepol-devel libtiff-devel libwebp-devel libxcb-devel libxml2-devel lua-srpm-macros mesa-libEGL-devel ocaml-srpm-macros openblas-srpm-macros openjpeg2-devel package-notes-srpm-macros pcre2-devel perl-srpm-macros pyproject-srpm-macros python-srpm-macros python3-devel qt5-designer qt5-doctools qt5-linguist qt5-qtbase-devel qt5-qttools-devel qt5-qttools-libs-designercomponents qt5-qttools-libs-help qt5-rpm-macros qt5-srpm-macros qt6-srpm-macros redhat-rpm-config rhash rpmautospec-rpm-macros rust-srpm-macros sysprof-capture-devel tcl-devel tk-devel vulkan-headers vulkan-loader-devel xorg-x11-proto-devel xz-devel zlib-devel
