#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y git gcc openssl cargo
mkdir /tmp/cargo-built/usr/bin

# Sheldon - https://github.com/rossmacarthur/sheldon
cargo install sheldon --path /tmp/cargo-built/usr/bin

# Krabby - https://github.com/yannjor/krabby
cargo install krabby --path /tmp/cargo-built/usr/bin

# MPD Discord RPC - https://github.com/JakeStanger/mpd-discord-rpc
cargo install mpd-discord-rpc --path /tmp/cargo-built/usr/bin