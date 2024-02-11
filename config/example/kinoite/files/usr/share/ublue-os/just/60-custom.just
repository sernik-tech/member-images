import '100-bling.just'
# Include some of your custom scripts here!

# remove all waydroid-related files in your user folders
reset-waydroid:
    bash -c 'sudo rm -rf /var/lib/waydroid /home/.waydroid ~/waydroid ~/.share/waydroid ~/.local/share/applications/*aydroid* ~/.local/share/waydroid'

# quickly initialize a waydroid image
init-waydroid:
    #!/usr/bin/env bash
    sudo waydroid init -c 'https://ota.waydro.id/system' -v 'https://ota.waydro.id/vendor'

# add user to "input" group
add-user-to-input-group:
    #!/usr/bin/bash
    if ! grep -q "input" /etc/group; then
      sudo bash -c 'grep "input" /lib/group >> /etc/group'
    fi
    sudo usermod -a -G input $USER

# install qemu/kvm virtualization and related software
enable-virtualization:
    #!/usr/bin/bash
    virt_test=$(rpm-ostree status | grep "virt-manager")
    if [[ -z ${virt_test} ]]; then
      echo "Installing QEMU and virt-manager..."
      rpm-ostree install -y virt-manager edk2-ovmf qemu
      rpm-ostree kargs \
      --append-if-missing="kvm.ignore_msrs=1" \
      --append-if-missing="kvm.report_ignored_msrs=0"
      echo 'Please re-run "ujust enable-virtualization" after the reboot to finish setup'
    else
      echo "Enabling libvirtd service"
      sudo systemctl enable --now libvirtd
      echo "libvirtd enabled! If virt-manager says libvirtd.sock is not available after a big update, re-run this command."
    fi

# fix vesktop discord rich presence
fix-vesktop-rpc:
    #!/usr/bin/bash
    echo "Enabling rich presence for native applications..."
    mkdir -p ~/.config/user-tmpfiles.d
    echo 'L %t/discord-ipc-0 - - - - .flatpak/dev.vencord.Vesktop/xdg-run/discord-ipc-0' > ~/.config/user-tmpfiles.d/discord-rpc.conf
    systemctl --user enable --now systemd-tmpfiles-setup.service
    echo "Enabling rich presence for flatpaks..."
    flatpak -u override --filesystem=xdg-run/.flatpak/dev.vencord.Vesktop:create
    flatpak -u override --filesystem=xdg-run/discord-ipc-*

# fix flatpak theme and cursor theme issues
flatpak-theme-fix:
  #!/usr/bin/bash
    echo "Fixing theme permissions..."
    flatpak -u override --filesystem=$HOME/.themes
    flatpak -u override --filesystem=$HOME/.local/share/themes
    flatpak -u override --filesystem=$HOME/.icons
    flatpak -u override --filesystem=/etc/fonts:ro
    echo "Fixing cursor permissions..."
    flatpak -u override --filesystem=/usr/share/icons/:ro
    flatpak -u override --filesystem=/var/home/$USER/.icons/:ro
    flatpak -u override --filesystem=xdg-config/gtk-3.0:ro
    flatpak -u override --env=XCURSOR_PATH=~/.icons
    echo "Done. If you have any issues, you may have to set these commands manually:"
    echo " "
    echo "Themes:"
    echo "flatpak -u override --env=GTK_THEME=theme_name_here"
    echo "flatpak -u override --env=ICON_THEME=icon_theme_name_here"
    echo " "
    echo "Cursors:"
    echo "flatpak -u override --env=XCURSOR_THEME=cursor_theme_name_here"
    echo "flatpak -u override --env=XCURSOR_SIZE=24"

# install papirus-colors icon pack
colored-papirus-icons:
    #!/usr/bin/bash
    git clone https://github.com/luisbocanegra/papirus-colors/ /tmp/papirus-colors
    chmod +x /tmp/papirus-colors/places_icons_mod.sh
    /tmp/papirus-colors/places_icons_mod.sh

# setup fingerprint reader on thinkpad t480
setup-t480-fingerprint:
    #!/usr/bin/bash
    echo "Installing required packages..."
    sudo wget https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/repo/fedora-$(rpm -E %fedora)/sneexy-python-validity-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/sneexy-python-validity-fedora-$(rpm -E %fedora).repo && \
    rpm-ostree override remove fprintd fprintd-pam --install open-fprintd --install fprintd-clients --install fprintd-clients-pam --install python3-validity
    echo "Preparing drivers..."
    sudo validity-sensors-firmware
    sudo python3 /usr/share/python-validity/playground/factory-reset.py
    echo "Enabling services..."
    sudo systemctl enable python3-validity open-fprintd-resume open-fprintd-suspend
    sudo systemctl start python3-validity
    echo "Done. Your fingerprint reader should now be functioning. May or may not require a reboot."
    echo "Enroll and test your fingerprint(s) with the following commands:"
    echo "fprintd-enroll"
    echo "fprintd-verify"
    echo " "
    echo "Then enable fingerprint authentication with the following commands:"
    echo "sudo authselect current"
    echo "sudo authselect enable-feature with-fingerprint"
    echo "sudo authselect apply-changes"

# add virtual audio channels/sinks named Game, Voice, Browser and Music which you can split audio to using qpwgraph, helvum, carla or other pipewire patchbays for use in OBS and other use cases
setup-virtual-channels:
    #!/bin/bash
    mkdir -p ~/.config/pipewire/pipewire.conf.d
    cat << 'EOL' > ~/.config/pipewire/pipewire.conf.d/virtual-channels.conf
    context.modules = [
        { name = libpipewire-module-loopback
            args = {
                node.description = "Game"
                capture.props = {
                    node.name      = "game_output"
                    media.class    = "Audio/Sink"
                    audio.position = [ FL FR ]
                }
                playback.props = {
                    node.name      = "playback.game_output"
                    audio.position = [ FL FR ]
                    node.passive   = true
                }
            }
        }
        { name = libpipewire-module-loopback
            args = {
                node.description = "Voice"
                capture.props = {
                    node.name      = "voice_output"
                    media.class    = "Audio/Sink"
                    audio.position = [ FL FR ]
                }
                playback.props = {
                    node.name      = "playback.voice_output"
                    audio.position = [ FL FR ]
                    node.passive   = true
                }
            }
        }
        { name = libpipewire-module-loopback
            args = {
                node.description = "Browser"
                capture.props = {
                    node.name      = "browser_output"
                    media.class    = "Audio/Sink"
                    audio.position = [ FL FR ]
                }
                playback.props = {
                    node.name      = "playback.browser_output"
                    audio.position = [ FL FR ]
                    node.passive   = true
                }
            }
        }
        { name = libpipewire-module-loopback
            args = {
                node.description = "Music"
                capture.props = {
                    node.name      = "music_output"
                    media.class    = "Audio/Sink"
                    audio.position = [ FL FR ]
                }
                playback.props = {
                    node.name      = "playback.music_output"
                    audio.position = [ FL FR ]
                    node.passive   = true
                }
            }
        }
    ]
    EOL
    echo "Next time you log in, you will have audio channels for Game, Voice, Browser, Music that you can route game audio to"
    echo "using programs like qpwgraph, helvum (installed) or carla."
    echo "You can also add these channels to OBS audio mixer for separate audio control for yourself and your viewers."
    echo "NOTE: It is recommended to mute the virtual channels so you do not have to listen to them twice if you are not exclusively routing the audio through said channel instead of splitting audio to them."

# remove the virtual audio sinks
remove-virtual-channels:
    rm ~/.config/pipewire/pipewire.conf.d/virtual-channels.conf
    echo "Virtual audio channels config removed, the channels will be removed next time you login."

# create fedora distrobox if it doesn't exist
[private]
distrobox-check-fedora:
    #!/bin/env bash
    source /usr/lib/ujust/ujust.sh
    if grep -qvz "fedora" <<< $(distrobox list); then
      echo "Setting up Fedora distrobox"
      Assemble noconfirmcreate "" "fedora"
    fi
