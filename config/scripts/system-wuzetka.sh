#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# systemd services to enable on the system
systemctl enable hblock.timer

# Ensure all required/used folders are created
mkdir -p /usr/share/sddm/themes

#
# Floorp fixes
#
sed -i 's@/opt/floorp/floorp@/usr/lib/opt/floorp/floorp@g' /usr/bin/floorp

#
# Blender fixes
#
sed -i 's@Exec=blender %f@Exec=env INTEL_DEBUG=reemit blender %f@g' /usr/share/applications/blender.desktop

#
# wgcf
#
WGCF_VER=$(curl -sL https://api.github.com/repos/ViRb3/wgcf/releases/latest | jq -r '.assets[] | select(.name? | match(".*_linux_amd64$")) | .browser_download_url')
curl -sL -o /usr/bin/wgcf ${WGCF_VER}
chmod +x /usr/bin/wgcf

#
# Thorium browser
#
THORIUM_VER=$(curl -sL https://api.github.com/repos/Alex313031/thorium/releases/latest | jq -r '.assets[] | select(.name? | match(".*_AVX2.rpm$")) | .browser_download_url')
curl -sL -o /tmp/thorium.rpm ${THORIUM_VER}
rpm-ostree install /tmp/thorium.rpm
ln -sf /usr/lib/opt/chromium.org/thorium/thorium-browser /usr/bin/thorium-browser
sed -i 's@/opt/chromium.org/thorium/thorium_shell@/usr/lib/opt/chromium.org/thorium/thorium_shell@g' /usr/bin/thorium-shell

#
# VSCodium
#
tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
rpm-ostree install codium

#
# MPD Discord RPC systemd service
#
curl -sL -o /usr/lib/systemd/user/mpd-discord-rpc.service https://raw.githubusercontent.com/JakeStanger/mpd-discord-rpc/master/mpd-discord-rpc.service

#
# Rescrobbled systemd service
#
curl -sL -o /usr/lib/systemd/user/rescrobbled.service https://raw.githubusercontent.com/InputUsername/rescrobbled/master/rescrobbled.service
sed -i 's@ExecStart=%h/.cargo/bin/rescrobbled@ExecStart=/usr/bin/rescrobbled@g' /usr/lib/systemd/user/rescrobbled.service

#
# Globally enable systemd user services
#
systemctl --global enable mpd.service \
    mpDris2.service \
    mpd-discord-rpc.service \
    rescrobbled.service

#
# SDDM Theme
#
cd /tmp
git clone https://github.com/Keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
rm -f /usr/share/sddm/themes/sddm-astronaut-theme/background.png
rm -f /usr/share/sddm/themes/sddm-astronaut-theme/README.md
rm -rf /usr/share/sddm/themes/sddm-astronaut-theme/Previews
rm -rf /usr/share/sddm/themes/sddm-astronaut-theme/Fonts
sed -i 's/ScreenWidth="1920"//' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's/ScreenHeight="1080"//' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's/## Adjust to your resolution to help SDDM speed up on calculations//' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@PartialBlur="true"@PartialBlur="false"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@FullBlur="false"@FullBlur="true"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@Font="Open Sans"@Font="Lexend"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
# catppuccinify
sed -i 's@MainColor="#F8F8F2"@MainColor="#cdd6f4"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@AccentColor="#343746"@AccentColor="#a6e3a1"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@BackgroundColor="#21222C"@BackgroundColor="#1e1e2e"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@placeholderColor="#bbbbbb"@placeholderColor="#6c7086"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf
sed -i 's@IconColor="#ffffff"@IconColor="#cdd6f4"@g' /usr/share/sddm/themes/sddm-astronaut-theme/theme.conf

#
# KDE Theme
#
cd /tmp
git clone https://github.com/catppuccin/kde.git catppuccinkde
cd catppuccinkde
rm -f install.sh
curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/config/scripts/catppuccin-plasma.sh
chmod +x install.sh
# Latte
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1
# Mocha
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1

#
# Papirus icon pack (From source)
#
cd /tmp
wget -qO- https://git.io/papirus-icon-theme-install | sh

#
# Tela icon pack
#
cd /tmp
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
chmod +x install.sh
./install.sh -c -d /usr/share/icons

#
# Papirus-folders
#
cd /tmp
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x papirus-folders
./papirus-folders -t Papirus-Light -C cat-latte-green
./papirus-folders -t Papirus-Dark -C cat-mocha-green

#
# Justfiles
#
wget "https://raw.githubusercontent.com/ublue-os/bazzite/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-waydroid.just" -O "/usr/share/ublue-os/just/31-waydroid.just"
wget "https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just" -O "/usr/share/ublue-os/just/62-bazzite-fixes.just"
wget "https://raw.githubusercontent.com/ublue-os/bazzite/main/system_files/desktop/shared/usr/share/ublue-os/just/83-bazzite-audio.just" -O "/usr/share/ublue-os/just/41-audio.just"
