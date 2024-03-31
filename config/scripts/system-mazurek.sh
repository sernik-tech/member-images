#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

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

# Pano
curl -sL -o /tmp/pano.zip https://github.com/oae/gnome-shell-pano/releases/latest/download/pano@elhan.io.zip
unzip /tmp/pano.zip -d /usr/share/gnome-shell/extensions/pano@elhan.io

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
curl -sL -o /tmp/bmw.zip https://github.com/Schneegans/Burn-My-Windows/releases/latest/download/burn-my-windows@schneegans.github.com.zip
unzip /tmp/bmw.zip -d /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
