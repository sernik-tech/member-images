#!/usr/bin/env bash
set -oue pipefail

# This script helps to replace KDE packages with KDE Plasma 6 variants.
# Only use this script until Fedora 40 releases/becomes available for Universal Blue images.
# !!!
# WARNING: Plasma 6 changes and breaks a bunch of custom extensions and the likes if they haven't been updated yet. We recommend not updating yet if you use a lot of them.
# NOTE: The copr repository this fetches packages from adds a file in `/etc/profile.d/disable-qml-cache.sh` which disables Qt's QML disk caching. If you experience any slow downs or freezes, change `QML_DISABLE_DISK_CACHE=1` to `QML_DISABLE_DISK_CACHE=0` in that file. If you experience crashes after changing that, then run `find "${XDG_CACHE_HOME:-$HOME/.cache}" -name qmlcache -type d -exec rm -rf "{}" \;`. If you still experience crashes, revert the change you made in `/etc/profile.d/disable-qml-cache.sh`.
# !!!

wget "https://copr.fedorainfracloud.org/coprs/solopasha/kde6/repo/fedora-$(rpm -E %fedora)/solopasha-kde6-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_solopasha-kde6.repo" # Fetch the KDE Plasma 6 repository
rpm-ostree override replace --experimental --from repo='copr:copr.fedorainfracloud.org:solopasha:kde6' akonadi-import-wizard \
    akonadi-server \
    akonadi-mime \
    akonadi-contacts \
    akonadi-notes \
    akonadi-search \
    akonadi-calendar \
    akonadi-import-wizard \
    baloo-widgets \
    kf6-baloo \
    bluedevil \
    breeze-gtk \
    breeze-icon \
    calendarsupport \
    colord-kde \
    desktop-backgrounds\
    eventviews \
    grantlee-editor \
    incidenceeditor \
    kaccounts-integration \
    kaccounts-providers \
    kaddressbook \
    kamera \
    kcharselect \
    kcron \
    kde-cli-tools \
    kde-connect \
    kde-gtk-config \
    kde-inotify-survey \
    kde-partitionmanager \
    xdg-desktop-portal-kde \
    xdg-utils \
    xwaylandvideobridge # We attempt to update as many applications as we can that are usually found within a stock Kinoite install (although list is based on Sneexy's kinoite image, so there is likely some extras in here that aren't supposed to be here but this should be a close enough list). In alphabetical order of the repositories' list of packages.
rpm-ostree override replace --experimental --from repo='copr:copr.fedorainfracloud.org:solopasha:kde6' ark \
    dolphin \
    dolphin-plugins \
    flatpak-kcm \
    gwenview \
    kalarm \
    kalk \
    kate \
    kcm_wacomtablet # Other packages that you may or may not have installed (example, if they're in flatpaks or if they're packages you manually layer yourself)
# You can refer to https://copr.fedorainfracloud.org/coprs/solopasha/kde6/packages/ to see other available packages you may want to install/upgrade.
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_solopasha-kde6.repo # Disable the repository. This is optional.
