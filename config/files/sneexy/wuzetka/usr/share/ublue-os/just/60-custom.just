# vim: set ft=make :

wuzetka-setup:
    # Wuzetka setup !!! sneexy ah setu p!!! real reeal real!!!!
    echo 'This script will set up everything that I (Sneexy) use and consider for a good experience setup.'
    echo 'Also fixes some things that may be broken out of the box or require additional setup.'
    echo
    echo 'You have 8 seconds to press CTRL + C and stop this script from running. Thanks for using Wuzetka!'
    sleep 8
    # Create an Arch distrobox container with everything properly configured and installed
    echo 'Creating Arch distrobox...'
    distrobox-create --image ghcr.io/ublue-os/arch-distrobox --name arch -Y
    # Install all software I use.
    # Software I used to layer manually before realizing I didn't have to and was too much for being on the base system.
    # We only use an Arch container since Arch is both the most up-to-date and widely available for many packages.
    # TODO: The package "bat" and below are reinstalled for Arch, taken from whats installed on the host side.
    # TODO: Maybe we can just use distrobox-host-exec instead of reinstalling the packages inside of the Arch container?
    distrobox-enter -n arch -- sh -c "/usr/bin/paru -Syu vscodium-bin \
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
        /usr/bin/distrobox-export --app codium && \
        /usr/bin/distrobox-export --bin /usr/bin/codium && \
        /usr/bin/distrobox-export --bin /usr/bin/adb && \
        /usr/bin/distrobox-export --bin /usr/bin/fastboot && \
        /usr/bin/distrobox-export --bin /usr/bin/scrcpy && \
        /usr/bin/distrobox-export --bin /usr/bin/beet"

    # Create an Bazzite-Arch distrobox container for gaming. Just create the box and export the applications I use
    echo 'Creating Bazzite-Arch distrobox...'
    distrobox-create --unshare-netns --image ghcr.io/ublue-os/bazzite-arch --name bazzite-arch -Y
