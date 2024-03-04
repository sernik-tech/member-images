#!/usr/bin/env bash

# This script will try to automate copying configuration files to the right place
# for new users logging in.
# It's powered by a custom user systemd unit that runs this script then disables
# itself when finished. First touches a file before running to prevent accidentally
# overridding any configuration or files.

# This script is split into 2 scripts, the other one *doesn't* check for a file before
# running, as it overwrites certain files that usually aren't permanent, don't require
# any user modification or may just randomly break.

# Tell this script to exit if there are any errors.
set -oue pipefail

# Confirm that the file doesn't exist and don't run if it does.
if [ -f $HOME/.local/share/.mazurek-post ]; then
    echo "Script has already been ran before. Exiting."
    return 1
fi

# All of our custom configurations and files are located under /usr/etc/mazurek if you
# want to look at them.

# We'll make sure the directories exist first.
mkdir -p $HOME/.config/hypr
mkdir -p $HOME/.config/waybar
mkdir -p $HOME/.local/bin

# We'll copy the files to the local user's directories.
cp -r /etc/mazurek/hypr/* $HOME/.config/hypr
cp -r /etc/mazurek/waybar/* $HOME/.config/waybar
cp /etc/mazurek/focus-mode.sh $HOME/.local/bin/focus-mode.sh
cp /etc/mazurek/restart-portal-wlr.sh $HOME/.local/bin/restart-portal-wlr.sh
cp /etc/mazurek/swww-random.sh $HOME/.local/bin/swww-random.sh

# Ensure the files are executable.
chmod +x $HOME/.local/bin/focus-mode.sh
chmod +x $HOME/.local/bin/restart-portal-wlr.sh
chmod +x $HOME/.local/bin/swww-random.sh

# Touch file to prevent this script from running twice.
touch $HOME/.local/share/.mazurek-post