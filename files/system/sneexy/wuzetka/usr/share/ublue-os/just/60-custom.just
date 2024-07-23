# vim: set ft=make :

wuzetka-setup:
    # Wuzetka setup !!! sneexy ah setu p!!! real reeal real!!!!
    echo 'This script will set up everything that I (Sneexy) use and consider for a good experience setup.'
    echo 'Also fixes some things that may be broken out of the box or require additional setup.'
    echo
    echo 'You have 8 seconds to press CTRL + C and stop this script from running. Thanks for using Wuzetka!'
    sleep 8
    # Symlink relative theme folders to fix certain issues
    echo 'Symlinking themes...'
    THEME_DIR=${HOME}/.local/share/themes/Catppuccin-Mocha-Compact-Green-Dark
    mkdir -p "${HOME}/.config/gtk-4.0"
    ln -sf "${THEME_DIR}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"
    ln -sf "${HOME}/.local/share/themes" "${HOME}/.themes"
    ln -sf "${HOME}/.local/share/icons" "${HOME}/.icons"
    # Create an Arch distrobox container with everything properly configured and installed
    echo 'Creating Arch distrobox...'
    distrobox-create --image ghcr.io/ublue-os/arch-distrobox --name arch -Y
    # Install all software I use.
    # Software I used to layer manually before realizing I didn't have to and was too much for being on the base system.
    # We only use an Arch container since Arch is both the most up-to-date and widely available for many packages.
    # TODO: The package "bat" and below are reinstalled for Arch, taken from whats installed on the host side.
    # TODO: Maybe we can just use distrobox-host-exec instead of reinstalling the packages inside of the Arch container?
    distrobox-enter -n arch -- sh -c "paru -Syu vscodium-bin \
        vscodium-bin-marketplace \
        android-tools \
        scrcpy \
        beets \
        chromaprint \
        ffmpeg \
        gst-libav \
        gst-plugins-bad \
        gst-plugins-good \
        gst-plugins-ugly \
        gst-python \
        imagemagick \
        python-beautifulsoup4 \
        python-discogs-client \
        python-flask \
        python-pyacoustid \
        python-pylast \
        python-requests \
        python-requests-oauthlib \
        python-pyxdg \
        bat \
        duf \
        fastfetch \
        fd \
        fzf \
        git-delta \
        eza \
        neovim \
        python-pynvim \
        wl-clipboard \
        ripgrep \
        sd \
        zoxide \
        zsh \
        sheldon \
        atuin \
        starship \
        krabby-bin \
        kitty-shell-integration \
        kitty-terminfo \
        --noconfirm && \
        distrobox-export --app codium && \
        distrobox-export --bin /usr/bin/codium && \
        distrobox-export --bin /usr/bin/adb && \
        distrobox-export --bin /usr/bin/fastboot && \
        distrobox-export --bin /usr/bin/scrcpy && \
        distrobox-export --bin /usr/bin/beet"
    # Create an Bazzite-Arch distrobox container for gaming. Just create the box and export the applications I use
    echo 'Creating Bazzite-Arch distrobox...'
    distrobox-create --unshare-netns --image ghcr.io/ublue-os/bazzite-arch --name bazzite-arch -Y
    distrobox-enter -n bazzite-arch -- sh -c "distrobox-export --app steam && \
        distrobox-export --app lutris && \
        distrobox-export --app protontricks && \
        distrobox-export --bin /usr/bin/steam && \
        distrobox-export --bin /usr/bin/steam-runtime && \
        distrobox-export --bin /usr/bin/steamcmd && \
        distrobox-export --bin /usr/bin/lutris && \
        distrobox-export --bin /usr/bin/protontricks && \
        distrobox-export --bin /usr/bin/protontricks-desktop-install && \
        distrobox-export --bin /usr/bin/protontricks-launch && \
        mkdir -p ~/.steam && distrobox-export --bin /usr/bin/steamcmd --export-path ~/.steam && mv ~/.steam/steamcmd ~/.steam/steamcmd.sh'"
