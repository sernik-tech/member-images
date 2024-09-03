#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y git gcc gcc-c++ cmake openssl protobuf protobuf-devel protobuf-compiler openssl-devel dbus-devel pkgconf-pkg-config \
    rustup cargo meson ninja-build \
    wayland-protocols-devel rust-libpulse-binding-devel rust-wayland-client-devel rust-wayland-protocols+wayland-client-devel \
    egl-wayland-devel egl-wayland egl-utils mesa-libEGL mesa-libEGL-devel \
    sassc rust-gdk0.17+v3_24-devel rust-libudev-devel gtk-layer-shell-devel libevdev-devel libinput-devel
mkdir -p /tmp/wayland-built/usr/bin

# SwayAudioIdleInhibit - https://github.com/ErikReider/SwayAudioIdleInhibit
cd /tmp
git clone https://github.com/ErikReider/SwayAudioIdleInhibit
cd SwayAudioIdleInhibit
meson build
ninja -C build
meson install -C build
cp build/sway-audio-idle-inhibit /tmp/wayland-built/usr/bin

# wpaperd - https://github.com/danyspin97/wpaperd
cd /tmp
git clone https://github.com/danyspin97/wpaperd
cd wpaperd
cargo build --release
cd target/release
cp wpaperd /tmp/wayland-built/usr/bin
cp wpaperctl /tmp/wayland-built/usr/bin

# SwayOSD - https://github.com/ErikReider/SwayOSD
cd /tmp
git clone https://github.com/ErikReider/SwayOSD
cd SwayOSD
meson setup build
ninja -C build
meson install -C build