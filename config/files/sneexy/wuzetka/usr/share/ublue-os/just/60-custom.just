# vim: set ft=make :

alias firefox := configure-firefox

# Configure Firefox with custom user.js and themes
configure-firefox ACTION="prompt":
    #!/usr/bin/bash
    source /usr/lib/ujust/ujust.sh
    OPTION={{ ACTION }}
    if [ "$OPTION" == "prompt" ]; then
      echo "${bold}Configuring Firefox (Flatpak)${normal}"
      echo 'What would you like to do?'
      OPTION=$(ugum choose "Install Betterfox user.js" "Install Firefox-UI-Fix" "Install Firefox GNOME Theme")
    elif [ "$OPTION" == "help" ]; then
      echo "Usage: ujust configure-firefox <option>"
      echo "  <option>: Specify the quick option - 'betterfox', 'ui-fix' or 'gnome-theme'"
      echo "  Use 'betterfox' to Install Betterfox's user.js configuration"
      echo "  Use 'ui-fix' to Install Firefox-UI-Fix"
      echo "  Use 'gnome-theme' to Install Firefox GNOME Theme"
      exit 0
    fi
    if [ "$OPTION" == "Install Betterfox user.js" ] || [ "${OPTION,,}" == "betterfox" ]; then
      if -f $HOME/.var/; then
        rpm-ostree kargs \
          --append-if-missing=rd.driver.blacklist=nouveau \
          --append-if-missing=modprobe.blacklist=nouveau \
          --append-if-missing=nvidia-drm.modeset=1 \
          --delete-if-present=nomodeset
      else
        echo 'You do not appear to be on a Nvidia image, please refer to the README for your uBlue-OS image.'
      fi
    elif [ "$OPTION" == "Test CUDA support" ] || [ "${OPTION,,}" == "test-cuda" ]; then
      if lsmod | grep -wq "nvidia"; then
        podman run \
          --user 1000:1000 \
          --security-opt=no-new-privileges \
          --cap-drop=ALL \
          --security-opt label=type:nvidia_container_t  \
          --device=nvidia.com/gpu=all \
          docker.io/nvidia/samples:vectoradd-cuda11.2.1
      else
        echo 'The Nvidia kernel module is not loaded. You may be using secure boot without the needed signing key, lacking the needed kargs, or may not be on a Nvidia image. See "just enroll-secure-boot-key" and "just nvidia-set-kargs".'
      fi
    elif [ "$OPTION" == "Enable Nvidia VAAPI in Firefox Flatpak" ] || [ "${OPTION,,}" == "firefox-vaapi" ]; then
      if lsmod | grep -wq "nvidia"; then
        flatpak override \
          --user \
          --filesystem=host-os \
          --env=LIBVA_DRIVER_NAME=nvidia \
          --env=LIBVA_DRIVERS_PATH=/run/host/usr/lib64/dri \
          --env=LIBVA_MESSAGING_LEVEL=1 \
          --env=MOZ_DISABLE_RDD_SANDBOX=1 \
          --env=NVD_BACKEND=direct \
          --env=MOZ_ENABLE_WAYLAND=1 \
          org.mozilla.firefox
      else
        echo 'The Nvidia kernel module is not loaded. You may be using secure boot without the needed signing key, lacking the needed kargs, or may not be on a Nvidia image. See "just enroll-secure-boot-key" and "just nvidia-set-kargs".'
      fi
    fi
