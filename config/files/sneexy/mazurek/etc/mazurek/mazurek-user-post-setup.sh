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
    exit
fi

# All of our custom configurations and files are located under /usr/etc/mazurek if you
# want to look at them.

# We'll make sure the directories exist first.
mkdir -p $HOME/.config/hypr
mkdir -p $HOME/.config/waybar
mkdir -p $HOME/.config/ags
mkdir -p $HOME/.local/bin

# We'll copy the files to the local user's directories, if they exist.

if [ -f $HOME/.config/hypr/hyprland.conf ]; then
    echo "Hyprland config exists. Skipping..."
else
    cp -r /etc/mazurek/hypr/* $HOME/.config/hypr
fi

# NOTE: to be removed after ags?
if [ -f $HOME/.config/waybar/config ]; then
    echo "Waybar config exists. Skipping..."
else
    cp -r /etc/mazurek/waybar/* $HOME/.config/waybar
fi

if [ -f $HOME/.config/ags ]; then
    echo "AGS config exists. Skipping..."
else
    cp -r /etc/mazurek/ags/* $HOME/.config/ags
fi

if [ -f $HOME/.local/bin/hypr-focus-mode.sh ]; then
    echo "Scripts exists. Skipping..."
else
    cp /etc/mazurek/hypr-focus-mode.sh $HOME/.local/bin/hypr-focus-mode.sh
fi

if [ -f $HOME/.local/bin/restart-portal-wlr.sh ]; then
    echo "Scripts exists. Skipping..."
else
    cp /etc/mazurek/restart-portal-wlr.sh $HOME/.local/bin/restart-portal-wlr.sh
fi

if [ -f $HOME/.local/bin/swww-random.sh ]; then
    echo "Scripts exists. Skipping..."
else
    cp /etc/mazurek/swww-random.sh $HOME/.local/bin/swww-random.sh
fi

# Ensure the files are executable.
chmod +x $HOME/.local/bin/focus-mode.sh
chmod +x $HOME/.local/bin/restart-portal-wlr.sh
chmod +x $HOME/.local/bin/swww-random.sh

# Run the extra stuff afterwards.
hyprctl dispatch exec waybar
hyprctl dispatch exec swaync

hyprctl reload

# Touch file to prevent this script from running twice.
touch $HOME/.local/share/.mazurek-post