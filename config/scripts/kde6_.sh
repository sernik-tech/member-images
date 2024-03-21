#!/usr/bin/env bash
set -oue pipefail

# This script helps to replace KDE packages with KDE Plasma 6 variants.
# Only use this script until Fedora 40 releases/becomes available for Universal Blue images.
# !!!
# WARNING: Plasma 6 changes and breaks a bunch of custom extensions and the likes if they haven't been updated yet. We recommend not updating yet if you use a lot of them.
# NOTE: The copr repository this fetches packages from adds a file in `/etc/profile.d/disable-qml-cache.sh` which disables Qt's QML disk caching. If you experience any slow downs or freezes, change `QML_DISABLE_DISK_CACHE=1` to `QML_DISABLE_DISK_CACHE=0` in that file. If you experience crashes after changing that, then run `find "${XDG_CACHE_HOME:-$HOME/.cache}" -name qmlcache -type d -exec rm -rf "{}" \;`. If you still experience crashes, revert the change you made in `/etc/profile.d/disable-qml-cache.sh`.
# !!!

wget "https://copr.fedorainfracloud.org/coprs/solopasha/kde6/repo/fedora-$(rpm -E %fedora)/solopasha-kde6-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_solopasha-kde6.repo" # Fetch the KDE Plasma 6 repository
rpm-ostree upgrade --from repo='copr:copr.fedorainfracloud.org:solopasha:kde6'
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_solopasha-kde6.repo # Disable the repository. This is optional.
