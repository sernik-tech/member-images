#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# installs sddm and related packages
rpm-ostree install sddm sddm-wayland-generic

# create sddm user
adduser sddm
