# vim: set ft=make :
   
sernik-distrobox:
        #!/usr/bin/bash
    source /usr/lib/ujust/ujust.sh
    OPTION={{ ACTION }}
    if [ "$OPTION" == "prompt" ]; then
      echo "${bold}Sernik Distrobox Menu${normal}"
      echo 'What would you like to do?'
      OPTION=$(ugum choose "Setup Fedora Distrobox" "Setup Ubuntu Distrobox" "Setup Arch Distrobox" "Setup Bazzite Arch Distrobox")
    elif [ "$OPTION" == "help" ]; then
      echo "Usage: ujust configure-nvidia <option>"
      echo "  <option>: Specify the quick option - 'fedora', 'ubuntu', 'arch' or 'bazzite-arch'"
      echo "  Use 'fedora' to set-up a pure Fedora distrobox."
      echo "  Use 'ubuntu' to set-up a pure Ubuntu distrobox."
      echo "  Use 'arch' to set-up a pure Arch distrobox."
      echo "  Use 'bazzite-arch' to set-up a Bazzite-arch distrobox for gaming."
      exit 0
    fi
    if [ "$OPTION" == "Setup Fedora Distrobox" ] || [ "${OPTION,,}" == "fedora" ]; then
      if distrobox ls | grep fedora; then
        echo 'You appear to already have a Fedora distrobox container set up. Exiting.'
      else
        if lsmod | grep -wq "nvidia"; then
            echo 'Nvidia detected. Setting up with Nvidia integration.'
            distrobox-create \
                --nvidia \
                -n fedora \
                -i ghcr.io/ublue-os/fedora-toolbox:latest \
                -Y
        else
            distrobox-create \
                -n fedora \
                -i ghcr.io/ublue-os/fedora-toolbox:latest \
                -Y
        fi
      fi
    elif [ "$OPTION" == "Setup Ubuntu Distrobox" ] || [ "${OPTION,,}" == "ubuntu" ]; then
      if distrobox ls | grep ubuntu; then
        echo 'You appear to already have an Ubuntu distrobox container set up. Exiting.'
      else
        if lsmod | grep -wq "nvidia"; then
            echo 'Nvidia detected. Setting up with Nvidia integration.'
            distrobox-create \
                --nvidia \
                -n ubuntu \
                -i ghcr.io/ublue-os/ubuntu-toolbox:latest \
                -Y
        else
            distrobox-create \
                -n ubuntu \
                -i ghcr.io/ublue-os/ubuntu-toolbox:latest \
                -Y
        fi
      fi
    elif [ "$OPTION" == "Setup Arch Distrobox" ] || [ "${OPTION,,}" == "arch" ]; then
      if distrobox ls | grep arch; then
        echo 'You appear to already have an Arch distrobox container set up. Exiting.'
      else
        if lsmod | grep -wq "nvidia"; then
            echo 'Nvidia detected. Setting up with Nvidia integration.'
            distrobox-create \
                --nvidia \
                -n arch \
                -i ghcr.io/ublue-os/arch-distrobox:latest \
                -Y
        else
            distrobox-create \
                -n arch \
                -i ghcr.io/ublue-os/arch-distrobox:latest \
                -Y
        fi
      fi
    elif [ "$OPTION" == "Setup Bazzite Arch Distrobox" ] || [ "${OPTION,,}" == "bazzite-arch" ]; then
      if distrobox ls | grep bazzite-arch; then
        echo 'You appear to already have a Bazzite Arch distrobox container set up. Exiting.'
      else
        if lsmod | grep -wq "nvidia"; then
            echo 'Nvidia detected. Setting up with Nvidia integration.'
            distrobox-create \
                --unshare-netns \
                --nvidia \
                --image ghcr.io/ublue-os/bazzite-arch:latest \
                --name bazzite-arch \
                -Y
        else
            distrobox-create \
                --unshare-netns \
                --image ghcr.io/ublue-os/bazzite-arch:latest \
                --name bazzite-arch \
                -Y
        fi
        echo
        echo 'Post setup:'
        echo

      fi
    fi

sernik-distrobox-extra:
