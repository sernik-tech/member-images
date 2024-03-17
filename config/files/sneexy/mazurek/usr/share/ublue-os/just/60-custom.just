mazurek:
    #!/usr/bin/env bash
    echo "WARNING: This is going to rewrite any configurations you have related to Hyprland and anything else."
    echo "You have 10 seconds to CTRL + C and stop this script."
    sleep 10
    mkdir -p $HOME/.config
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.themes
    mkdir -p $HOME/.icons
    cp -rf /etc/skel/.config/* $HOME/.config
    cp -rf /etc/skel/.local/* $HOME/.local

    chmod +x $HOME/.local/bin/*
