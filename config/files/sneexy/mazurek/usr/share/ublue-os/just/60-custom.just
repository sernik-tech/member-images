alias mazurek := configure-mazurek

configure-mazurek:
    #!/usr/bin/bash
    source /usr/lib/ujust/ujust.sh
    OPTION={{ ACTION }}
    if [ "$OPTION" == "prompt" ]; then
      echo "${bold}Mazurek Configurations${normal}"
      echo 'Custom set of commands for easier post-install management. Usually the one most used by the image maintainer.'
      echo 'Also check out ${u}just themes${normal} for changing your GNOME theme! Compatibility and general maintenance not guaranteed.'
      OPTION=$(ugum choose "Set up basic distrobox containers" "Test CUDA support" "Enable Nvidia VAAPI in Firefox Flatpak")
    elif [ "$OPTION" == "help" ]; then
      echo "Usage: just configure-mazurek <option>"
      echo "  <option>: Specify the quick option - 'distrobox-setup', 'test-cuda' or 'firefox-vaapi'"
      echo "  Use 'distrobox-setup' to quickly set up customized distrobox containers (Fedora and Arch)"
      echo "  Use 'test-cuda' to Test CUDA support"
      echo "  Use 'firefox-vaapi' to Enable Nvidia VAAPI in Firefox Flatpak."
      exit 0
    fi
    if [ "$OPTION" == "Set up basic distrobox containers" ] || [ "${OPTION,,}" == "distrobox-setup" ]; then
      echo "Now starting the installation of Distrobox containers."
      echo "Fedora will be installed and configured with tools and utilities that a common user would need (yt-dlp, adb, etc.)"
      echo "Arch will be installed and configured to be the gaming (Steam) and development (VSCodium) container."
      echo "This will take a while, especially "
      if command -v distrobox; then
        # Install fedora, install process based on mazurek.
        if distrobox ls | grep "fedora"; then
          echo "Fedora container detected. We will not modify it just for the sake of preventing any unnecessary issues."
        else
          echo "Installing Fedora..."
          distrobox-create --image ghcr.io/ublue-os/fedora-toolbox:latest --name fedora --additional-packages "bat \
	    duf \
	    fastfetch \
	    fd-find \
	    fzf \
	    git-delta \
	    lsd \
	    neovim \
	    ripgrep \
	    sd \
	    zoxide \
	    zsh \
	    cargo \
	    kitty-shell-integration \
	    kitty-terminfo"
	fi
	# Install Arch container. Install process inspired by bazzite-arch but I/we aren't using it specifically because it comes with OBS which I don't need/has a dedicated container for it. Also for more control over what is installed.
	if distrobox ls | grep "arch"; then
	  echo "Arch container detected. We will not modify it just for the sake of preventing any unnecessary issues."
        else
          echo "Installing Arch..."
	  distrobox-create --image ghcr.io/ublue-os/arch-distrobox --name arch --additional-packages "lib32-vulkan-radeon \
            libva-mesa-driver \
            intel-media-driver \
            vulkan-mesa-layers \
            lib32-vulkan-mesa-layers \
            lib32-libnm \
            openal \
            pipewire \
            pipewire-pulse \
            pipewire-alsa \
            pipewire-jack \
            wireplumber \
            lib32-pipewire \
            lib32-pipewire-jack \
            lib32-libpulse \
            lib32-openal \
            xdg-desktop-portal-gnome \
            xdg-desktop-portal-gtk \
            neovim \
            hyfetch \
            zsh \
            yad \
            xdg-user-dirs \
            xdotool \
            xorg-xwininfo \
            wmctrl \
            wxwidgets-gtk3 \
            rocm-opencl-runtime \
            rocm-hip-runtime \
            libbsd \
            noto-fonts-cjk \
            qt6-multimedia-ffmpeg"
          distrobox-enter --name arch -- sudo pacman -Syu steam mangohud lib32-mangohud --noconfirm
          distrobox-enter --name arch -- sudo wget https://raw.githubusercontent.com/Shringe/LatencyFleX-Installer/main/install.sh -O /usr/bin/latencyflex
          distrobox-enter --name arch -- sudo mkdir -p /usr/share/latencyflex/
	  distrobox-enter --name arch -- sudo wget https://raw.githubusercontent.com/ublue-os/bazzite-arch/main/system_files/usr/share/latencyflex/dxvk.conf -O /usr/share/latencyflex/dxvk.conf
	  distrobox-enter --name arch -- sudo sed -i 's@"dxvk.conf"@"/usr/share/latencyflex/dxvk.conf"@g' /usr/bin/latencyflex
	  distrobox-enter --name arch -- sudo chmod +x /usr/bin/latencyflex
	  distrobox-enter --name arch -- paru -S aur/protontricks \
	    aur/vkbasalt \
	    aur/lib32-vkbasalt \
	    aur/lib32-gperftools \
	    aur/steamcmd \
	    --noconfirm
        fi
      else
        echo 'Strange. Distrobox isn't installed... Try to reinstall, or layer the package onto your system.'
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
