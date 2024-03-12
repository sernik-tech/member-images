#!/usr/bin/env bash

set -oue pipefail

# Adds the user required for GDM to the /etc/passwd and /etc/group file to allow it working on boot. Prevents issues such as blank screens when booting.

# Add GDM group to /etc/group
echo 'gdm:x:42:gdm' >> /etc/group

# Add GDM user to /etc/passwd
echo 'gdm:x:42:gdm:GNOME Display Manager:/var/lib/gdm:/sbin/nologin' >> /etc/passwd
