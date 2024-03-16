#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# add a few copr repos

# bazzite repositories
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
# multilib
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# bazzite packages
rpm-ostree install joystickwake xwiimote-ng

# remove default hyprland terminal
rpm-ostree override remove kitty

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tofik-nwg-shell-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:manuelschneid3r.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/peterwu-rendezvous-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo

#
# create all required folders for the following setup
#
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /usr/share/qt5ct/colors
mkdir -p /usr/share/qt6ct/colors
mkdir -p /etc/skel/.config/nvim
mkdir -p /etc/skel/.local
mkdir -p /usr/share/icons
mkdir -p /usr/share/backgrounds/catppuccin

#
# Catppuccin setup
#

# GTK Theme

# install dependencies
rpm-ostree install sassc inkscape optipng

# clone gtk repo
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk

# python virtual env & theme install
python3 -m venv /tmp/gtk
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact -d /usr/share/themes

# QT(5/6CT) Theme

# Clone the folder (A fork used with a fix as the original repo is inactive)
git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct

# Copy files to respective locations
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors

# Papirus Folders

# Clone the script
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
chmod +x /tmp/papirus-folders/papirus-folders

# Copy the contents to the system installed icons. because of this, we need to run
# this script AFTER installing the icons to ensure nothing goes wrong.
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus

# Change the color of the icon theme
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

#
# NvChad
#

# clone the starting repo into the proper location of user's files
git clone https://github.com/NvChad/starter.git /etc/skel/.config/nvim

#
# Dotfiles
#

# clone dotfiles manually from repo and copy them to /etc/skel for user dotfiles
git clone https://git.gay/sneexy/mazurek-dots.git /tmp/dotfiles
cp -rf /tmp/dotfiles/config/* /etc/skel/.config
cp -rf /tmp/dotfiles/local/* /etc/skel/.local
cp -rf /tmp/dotfiles/icons/* /usr/share/icons
cp -rf /tmp/dotfiles/wallpapers/mazurek-catppuccin/* /usr/share/backgrounds/catppuccin

# ensure bins are executable
chmod +x /etc/skel/.local/bin/*

# Clean up
rm -rf /tmp/gtk
rm -rf /tmp/qt6ct
rm -rf /tmp/papirus-folders
rm -rf /tmp/dotfiles
rpm-ostree override remove sassc inkscape optipng
