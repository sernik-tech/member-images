mazurek:
    #!/usr/bin/env bash
    echo "WARNING: This is going to rewrite any configurations you have related to Hyprland and anything else."
    echo "You have 10 seconds to CTRL + C and stop this script."
    sleep 10
    mkdir -p $HOME/.config
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.local/share/themes
    mkdir -p $HOME/.local/share/icons
    cp -rf /etc/skel/* $HOME/
    chmod +x $HOME/.local/bin/*

mazurek-first-time:
    #!/usr/bin/env bash
    if [ -f $HOME/.local/share/.mazurek-first-done ]; then
        echo "First time setup already ran. Exiting..."
        exit
    else
        mkdir -p $HOME/.themes
        mkdir -p $HOME/.icons
        ln -s $HOME/.local/share/themes $HOME/.themes
        ln -s $HOME/.local/share/icons $HOME/.icons
        $HOME/.local/bin/mazurek-first-time-messages
        touch $HOME/.local/share/.mazurek-first-done
    fi
