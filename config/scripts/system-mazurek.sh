#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Quick envvars to quickly change things if required
# We can do better and use a tiny one-liner or something to automatically detect and download the latest version
PANO_EXT=https://github.com/oae/gnome-shell-pano/releases/download/v22/pano@elhan.io.zip # see: https://github.com/oae/gnome-shell-pano/releases
#BMW_EXT=https://github.com/Schneegans/Burn-My-Windows/releases/download/v41/burn-my-windows@schneegans.github.com.zip # see: https://github.com/Schneegans/Burn-My-Windows/releases

# bazzite repositories and packages
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"
rpm-ostree install joystickwake xwiimote-ng

mkdir -p /usr/share/Kvantum
mkdir -p /usr/share/qt5ct/colors
mkdir -p /usr/share/qt6ct/colors
mkdir -p /usr/share/icons
mkdir -p /usr/share/gnome-shell/extensions/paperwm@paperwm.github.com
mkdir -p /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com
mkdir -p /usr/share/gnome-shell/extensions/pano@elhan.io
mkdir -p /usr/etc/skel/.local/share/themes
mkdir -p /usr/etc/skel/.var/app/org.gnome.gedit/data/gedit/styles

# Catppuccin GTK Theme
rpm-ostree install sassc inkscape optipng
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk
python3 -m venv /tmp/gtk/venv
source /tmp/gtk/venv/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/venv/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact --tweaks float -d /usr/etc/skel/.local/share/themes

# Catppuccin QT(5/6CT) Theme
git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors

# Papirus (Folders)
# remember you need the package to be installed
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

# Gedit
git clone https://github.com/catppuccin/gedit.git /tmp/gedit
cp -r /tmp/gedit/themes/* /usr/etc/skel/.var/app/org.gnome.gedit/data/gedit/styles

# GNOME Extensions

# Panoyarn install
#rpm-ostree install nodejs cogl-devel gsound-devel libgda-devel
#npm install -g corepack
#corepack enable
wget $PANO_EXT -O "/tmp/pano.zip"
unzip /tmp/pano.zip -d /usr/share/gnome-shell/extensions/pano@elhan.io
#git clone https://github.com/oae/gnome-shell-pano.git /tmp/pano
#cd /tmp/pano && yes | yarn install
#cd /tmp/pano && yarn build
#npm remove -g corepack
#rpm-ostree override remove nodejs cogl-devel gsound-devel libgda-devel
#rm -rf /usr/local/lib/node_modules

# PaperWM
git clone https://github.com/paperwm/PaperWM.git /tmp/paperwm
rm -rf /tmp/paperwm/.git
rm -rf /tmp/paperwm/.github
rm -rf /tmp/paperwm/.gitignore
rm -rf /tmp/paperwm/.eslintrc.yml
rm -rf /tmp/paperwm/media
rm -rf /tmp/paperwm/README.md
rm -rf /tmp/paperwm/CONTRIBUTING.md
rm -rf /tmp/paperwm/install.sh
rm -rf /tmp/paperwm/uninstall.sh
cp -r /tmp/paperwm/* /usr/share/gnome-shell/extensions/paperwm@paperwm.github.com

# Burn My Windows
#wget $BMW_EXT -O "/tmp/bmw.zip"
#unzip /tmp/pano.zip -d /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com
git clone https://github.com/Schneegans/Burn-My-Windows.git /tmp/bmw
cd /tmp/bmw && make install
unzip /tmp/bmw/burn-my-windows@schneegans.github.com.zip -d /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com
#rm -rf /tmp/bmw/.git
#rm -rf /tmp/bmw/.github
#rm -rf /tmp/bmw/.reuse
#rm -rf /tmp/bmw/.clang-format
#rm -rf /tmp/bmw/.gitignore
#rm -rf /tmp/bmw/LICENSES
#rm -rf /tmp/bmw/docs
#rm -rf /tmp/bmw/kwin
#rm -rf /tmp/bmw/scripts
#rm -rf /tmp/bmw/po
#rm -rf /tmp/bmw/tests
#rm -rf /tmp/bmw/assets
#rm -rf /tmp/bmw/Makefile
#rm -rf /tmp/bmw/README.md
#cp -r /tmp/bmw/* /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
