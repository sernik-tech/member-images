#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Install python3-pip if it's not already installed
if ! rpm -q python3-pip > /dev/null; then
    rpm-ostree install python3-pip
fi

# Install the backend and other dependicies with pip
pip install --prefix=/usr kde-material-you-colors
pip install --prefix=/usr pywal

rpm-ostree install gcc
