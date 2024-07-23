#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

#
# wgcf
#
WGCF_VER=$(curl -sL https://api.github.com/repos/ViRb3/wgcf/releases/latest | jq -r '.assets[] | select(.name? | match(".*_linux_amd64$")) | .browser_download_url')
curl -sL -o /usr/bin/wgcf ${WGCF_VER}
chmod +x /usr/bin/wgcf

# Unite Shell Extension (The Fedora package relies on the extension from GNOME Extensions which has stopped recieving updates it seems)
UNITE_VER=$(curl -sL https://api.github.com/repos/hardpixel/unite-shell/releases/latest | jq -r '.assets[] | select(.name? | match("unite-shell.*.zip$")) | .browser_download_url')
curl -sL -o /tmp/unite.zip ${UNITE_VER}
unzip /tmp/unite.zip -d /usr/share/gnome-shell/extensions/unite@hardpixel.eu