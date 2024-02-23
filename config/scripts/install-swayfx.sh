#!/usr/bin/env bash

set -oue pipefail

# Enable swayfx repo just to install swayfx
echo "Adding swayfx repository"

wget https://copr.fedorainfracloud.org/coprs/swayfx/swayfx/repo/fedora-${OS_VERSION}/swayfx-swayfx-fedora-${OS_VERSION}.repo?arch=x86_64 -O /etc/yum.repos.d/_copr_swayfx-swayfx.repo

# Ensure that needed Mesa packages are installed from bazzite-multilib
echo "Replacing sway with swayfx"

#rpm-ostree override remove sway --install swayfx
rpm-ostree install swayfx

# Cleanup
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_swayfx-swayfx.repo
