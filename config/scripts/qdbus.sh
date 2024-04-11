#!/bin/sh

set -oeux pipefail

# symlink it as fedora for some reason uses qdbus-qt6 instead of just qdbus
ln -sf /usr/bin/qdbus-qt6 /usr/bin/qdbus
