#!/usr/bin/env bash

# This script will try to automate copying configuration files to the right place
# for new users logging in.
# It's powered by a custom user systemd unit that runs this script then disables
# itself when finished. First touches a file before running to prevent accidentally
# overridding any configuration or files.

# Tell this script to exit if there are any errors.
set -oue pipefail

# Confirm that the file doesn't exist and don't run if it does.
if [ -f $HOME/.local/share/.mazurek ]; then
    echo "Script has already been ran before. Exiting."
    if "systemctl --user status mazurek-user-setup.service | grep \"; enabled;\""; then
        systemctl --user disable mazurek-user-setup.service
    fi
    return 1
    exit
fi

# All of our custom configurations and files are located under /usr/etc/mazurek if you
# want to look at them.

# We'll make sure the directories exist first.
mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

# We'll copy the files to the local user's directories.
cp -rf /etc/mazurek/config/* $HOME/.config
cp /etc/mazurek/bin/* $HOME/.local/bin

# Ensure the files are executable.
chmod +x $HOME/.local/bin/hypr-focus-mode
chmod +x $HOME/.local/bin/restart-portal-wlr
chmod +x $HOME/.local/bin/swww-random

# Run the extra stuff afterwards.
hyprctl dispatch exec waybar
hyprctl dispatch exec swaync

# Reload hyprland config.
hyprctl reload

# Disable service.
systemctl --user disable mazurek-user-setup.service

# Touch file to prevent this script from running twice.
touch $HOME/.local/share/.mazurek

# Launch first time messages.
/bin/bash -c "$(/etc/mazurek/mazurek-first-time-messages.sh)"
