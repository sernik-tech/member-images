#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# systemd services to enable on the system
systemctl enable hblock.timer

# Ensure all required/used folders are created
mkdir -p /etc/skel/.local/share/icons
mkdir -p /usr/share/sddm/themes

#
# Floorp fixes
#
sed -i 's@/opt/floorp/floorp@/usr/lib/opt/floorp/floorp@g' /usr/bin/floorp-ablaze
ln -sf /usr/bin/floorp-ablaze /usr/bin/floorp

#
# Bazzite packages
# Enables bazzite repositories to install extra software then disables them afterwards to prevent installing software from their repos
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
rpm-ostree install \
    joystickwake \
    xwiimote-ng
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

#
# wgcf
#
WGCF_VER=$(curl -sL https://api.github.com/repos/ViRb3/wgcf/releases/latest | jq -r '.assets[] | select(.name? | match("wgcf_.*_linux_amd64$")) | .browser_download_url')
curl -sL -o /usr/bin/wgcf ${WGCF_VER}
chmod +x /usr/bin/wgcf

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
git clone https://github.com/catppuccin/sddm.git catppuccin-sddm
cp -r /tmp/catppuccin-sddm/src /usr/share/sddm/themes
mv /usr/share/sddm/themes/src /usr/share/sddm/themes/catppuccin-mocha
cp /tmp/catppuccin-sddm/pertheme/mocha.conf /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@Font="Noto Sans"@Font="Lexend Deca"@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@FontSize=9@FontSize=11@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@# PasswordShowLastLetter=1000@PasswordShowLastLetter=1000@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf
sed -i 's@Font="Noto Sans"@Font="Lexend Deca"@g' /usr/share/sddm/themes/catppuccin-mocha/theme.conf

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
# Tela icon pack
#
cd /tmp
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
chmod +x install.sh
./install.sh -c -d /usr/share/icons

#
# Colloid icon pack
#
cd /tmp
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
chmod +x install.sh
./install.sh -t default -d /usr/share/icons

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
