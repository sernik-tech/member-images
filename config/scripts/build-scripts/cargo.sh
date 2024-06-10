#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y git gcc gcc-c++ cmake openssl protobuf-compiler openssl-devel dbus-devel pkgconf-pkg-config cargo
mkdir -p /tmp/cargo-built/usr/bin

# Atuin - https://github.com/atuinsh/atuin
cargo install atuin --root /tmp/cargo-built/usr

# Starship - https://starship.rs/
cargo install starship --root /tmp/cargo-built/usr

# Sheldon - https://github.com/rossmacarthur/sheldon
cargo install sheldon --root /tmp/cargo-built/usr

# Krabby - https://github.com/yannjor/krabby
cargo install krabby --root /tmp/cargo-built/usr

# MPD Discord RPC - https://github.com/JakeStanger/mpd-discord-rpc
cargo install mpd-discord-rpc --root /tmp/cargo-built/usr

# Rescrobbled - https://github.com/InputUsername/rescrobbled
cargo install rescrobbled --root /tmp/cargo-built/usr

# tlrc - https://github.com/tldr-pages/tlrc
cargo install tlrc --root /tmp/cargo-built/usr