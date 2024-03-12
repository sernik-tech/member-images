#!/usr/bin/env bash

set -oue pipefail

# Adds the SDDM to the /etc/passwd and /etc/group files to allow it working on first boot without any extra manual intervention.

# Generate group and user numbers randomly as they're randomly generated for SDDM
GROUP_NUMBER=$(shuf --random-source /dev/urandom -i 900-999 -n 1)
USER_NUMBER=$(shuf --random-source /dev/urandom -i 900-999 -n 1)

# Add SDDM group to /etc/group
echo 'sddm:x:'$GROUP_NUMBER':sddm' >> /etc/group

# Add SDDM user to /etc/passwd
echo 'sddm:x:'$USER_NUMBER':sddm:SDDM Greeter Account:/var/lib/sddm:/sbin/nologin' >> /etc/passwd
