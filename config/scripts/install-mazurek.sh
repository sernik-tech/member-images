#!/usr/bin/env bash

set -oue pipefail

# Enable repos to install packages
echo "Adding copr repositories"

# swayfx
wget https://copr.fedorainfracloud.org/coprs/swayfx/swayfx/repo/fedora-${OS_VERSION}/swayfx-swayfx-fedora-${OS_VERSION}.repo?arch=x86_64 -O /etc/yum.repos.d/_copr_swayfx-swayfx.repo
# swaync/SwayNotificationCenter
wget https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-${OS_VERSION}/erikreider-SwayNotificationCenter-fedora-${OS_VERSION}.repo?arch=x86_64 -O /etc/yum.repos.d/_copr_erikreider-SwayNotificationCenter.repo
# swaylock-effects
wget https://copr.fedorainfracloud.org/coprs/vrumger/swaylock-effects/repo/fedora-${OS_VERSION}/swayfx-swayfx-fedora-${OS_VERSION}.repo?arch=x86_64 -O /etc/yum.repos.d/_copr_vrumger-swaylock-effects.repo

# install packages
echo "Installing packages"

#rpm-ostree install swaylock-effects
rpm-ostree install swayfx
rpm-ostree install SwayNotificationCenter

# disable repos afterwards
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_swayfx-swayfx.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_erikreider-SwayNotificationCenter.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_vrumger-swaylock-effects.repo
