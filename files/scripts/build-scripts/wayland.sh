#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y git gcc gcc-c++ cmake openssl protobuf protobuf-devel protobuf-compiler openssl-devel dbus-devel pkgconf-pkg-config \
    rustup cargo meson ninja-build \
    wayland-protocols-devel rust-libpulse-binding-devel rust-wayland-client-devel rust-wayland-protocols+wayland-client-devel \
    scdoc egl-wayland-devel egl-wayland egl-utils mesa-libEGL mesa-libEGL-devel \
    sassc rust-gdk0.17+v3_24-devel rust-libudev-devel gtk-layer-shell-devel libevdev-devel libinput-devel
mkdir -p /tmp/wayland-built/usr/bin

# rinstall (Only used here for some packages)
cd /tmp
git clone https://github.com/DanySpin97/rinstall
cd rinstall
cargo build --release
chmod +x ./target/release/rinstall

# SwayAudioIdleInhibit - https://github.com/ErikReider/SwayAudioIdleInhibit
cd /tmp
git clone https://github.com/ErikReider/SwayAudioIdleInhibit
cd SwayAudioIdleInhibit
meson build
ninja -C build
meson install -C build --destdir "/tmp/wayland-built"
mv /tmp/wayland-built/usr/local/bin/sway-audio-idle-inhibit /tmp/wayland-built/usr/bin

# wpaperd - https://github.com/danyspin97/wpaperd
cd /tmp
git clone https://github.com/danyspin97/wpaperd
cd wpaperd
cargo build --release
scdoc < man/wpaperd-output.5.scd > man/wpaperd-output.5
/tmp/rinstall/target/release/rinstall install -D "/tmp/wayland-built" -y

# SwayOSD - https://github.com/ErikReider/SwayOSD
cd /tmp
git clone https://github.com/ErikReider/SwayOSD
cd SwayOSD
meson setup build
ninja -C build
meson install -C build --destdir "/tmp/wayland-built"
