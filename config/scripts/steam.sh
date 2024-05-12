#!/usr/bin/env bash
# Taken from Bazzite. Steam RPM is fucking hell
# https://github.com/ublue-os/bazzite/blob/a37b7154324db712d951b7083bd45204e788dd55/Containerfile#L352
# Note that I also did some modifications to fix issues but I didn't bother to fix them properly. Just to make the issues go away.

set -oue pipefail

# Update packages that commonly cause build issues
rpm-ostree override replace \
--experimental \
--from repo=updates \
    vulkan-loader \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    alsa-lib \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    gnutls \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    glib2 \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    gtk3 \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    atk \
    at-spi2-atk \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libaom \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    gstreamer1 \
    gstreamer1-plugins-base \
    gstreamer1-plugins-bad-free-libs \
    gstreamer1-plugins-good-qt \
    gstreamer1-plugins-good \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugin-libav \
    gstreamer1-plugins-ugly-free \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    python3 \
    python3-libs \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libdecor \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libtirpc \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libuuid \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libblkid \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libmount \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    cups-libs \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libinput \
    || true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
    libopenmpt \
    || true && \
rpm-ostree override remove \
    glibc32 \
    || true

# Install extra dependencies
rpm-ostree install \
    pulseaudio-utils \
    mesa-libGLU \
    vulkan-tools \
    glibc.i686 \

# from what i can gather here:
# 1. pre-install any libraries or dependencies
# 2. toggling different repos and installing the correct versions of libraries and software (this part is pain)
# 3. installing extra dependencies and useful applications
# 4. install latencyflex
rpm-ostree install \
    at-spi2-core.i686 \
    atk.i686 \
    vulkan-loader.i686 \
    alsa-lib.i686 \
    fontconfig.i686 \
    gtk2.i686 \
    libICE.i686 \
    libnsl.i686 \
    libxcrypt-compat.i686 \
    libpng12.i686 \
    libXext.i686 \
    libXinerama.i686 \
    libXtst.i686 \
    libXScrnSaver.i686 \
    NetworkManager-libnm.i686 \
    nss.i686 \
    pulseaudio-libs.i686 \
    libcurl.i686 \
    systemd-libs.i686 \
    libva.i686 \
    libvdpau.i686 \
    libdbusmenu-gtk3.i686 \
    libatomic.i686 \
    pipewire-alsa.i686 \
    clinfo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/fedora-updates.repo && \
rpm-ostree install \
    mesa-vulkan-drivers.i686 \
    mesa-va-drivers-freeworld.i686 \
    mesa-vdpau-drivers-freeworld.i686 && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo && \
rpm-ostree install \
    steam && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-updates.repo && \
rpm-ostree install \
    fluidsynth \
    fluid-soundfont-gm \
    qsynth \
    wxGTK \
    libFAudio \
    wine-core.x86_64 \
    wine-core.i686 \
    wine-pulseaudio.x86_64 \
    wine-pulseaudio.i686 \
    winetricks \
    protontricks \
    latencyflex-vulkan-layer \
    vkBasalt.x86_64 \
    vkBasalt.i686 \
    mangohud.x86_64 \
    mangohud.i686 \
    vk_hdr_layer.x86_64 \
    vk_hdr_layer.i686 && \
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/winetricks.desktop && \
curl -Lo /tmp/latencyflex.tar.xz $(curl https://api.github.com/repos/ishitatsuyuki/LatencyFleX/releases/latest | jq -r '.assets[] | select(.name| test(".*.tar.xz$")).browser_download_url') && \
mkdir -p /tmp/latencyflex && \
tar --no-same-owner --no-same-permissions --no-overwrite-dir --strip-components 1 -xvf /tmp/latencyflex.tar.xz -C /tmp/latencyflex && \
rm -f /tmp/latencyflex.tar.xz && \
cp -r /tmp/latencyflex/wine/usr/lib/wine/* /usr/lib64/wine/ && \
rm -rf /tmp/latencyflex && \
curl -Lo /usr/bin/latencyflex https://raw.githubusercontent.com/KyleGospo/LatencyFleX-Installer/main/install.sh && \
chmod +x /usr/bin/latencyflex && \
sed -i 's@/usr/lib/wine/@/usr/lib64/wine/@g' /usr/bin/latencyflex && \
sed -i 's@"dxvk.conf"@"/usr/share/latencyflex/dxvk.conf"@g' /usr/bin/latencyflex && \
chmod +x /usr/bin/latencyflex
