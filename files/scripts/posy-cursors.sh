#!/usr/bin/env bash
# taken from https://github.com/AuraHerreroRuiz/auraos !!
# https://github.com/AuraHerreroRuiz/auraos/blob/main/config/scripts/posy-cursors.sh

set -oue pipefail
#clone git repository
cd /tmp
git clone "https://github.com/AuraHerreroRuiz/Posys-improved-cursors-linux.git"
cd Posys-improved-cursors-linux
git checkout "$(git tag --sort=tag --list 'v[0-9]*' | tail -n 1)"
cp -r Themes/* /usr/share/icons/