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

# remove kitty terminal (needs to be done here because its after hyprland is installed)
rpm-ostree override remove kitty

#
# create all required folders for the following setup
#
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /usr/share/qt5ct/colors
mkdir -p /usr/share/qt6ct/colors
mkdir -p /etc/mazurek
mkdir -p /etc/skel/.themes
mkdir -p /etc/skel/.icons
mkdir -p /etc/skel/.config/nvim
mkdir -p /etc/skel/.local/share/themes
mkdir -p /etc/skel/.local/share/icons
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
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact -d /etc/skel/.local/share/themes

# QT(5/6CT) Theme

# Clone the folder (A fork used with a fix as the original repo is inactive)
git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct

# Copy files to respective locations
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors

# Papirus (Folders)

# Download and install Papirus icons (Avoiding system package to install to user directory)
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="/etc/skel/.local/share/icons" sh

# Clone the script & copy the contents to the installed icons.
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /etc/skel/.local/share/icons/Papirus

# Change the color of the icon theme using original papirus-folders script
wget -qO- https://git.io/papirus-folders-install | env PREFIX=/etc/skel/.local sh
/etc/skel/.local/bin/papirus-folders -t /etc/skel/.local/share/icons/Papirus-Dark -C cat-mocha-green

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
cp -rf /tmp/dotfiles/icons/* /etc/skel/.local/share/icons
cp -rf /tmp/dotfiles/wallpapers/mazurek-catppuccin/* /usr/share/backgrounds/catppuccin

# ensure bins are executable
chmod +x /etc/skel/.local/bin/*

#
# Clean up
#
rm -rf /tmp/gtk
rm -rf /tmp/qt6ct
rm -rf /tmp/papirus-folders
rm -rf /tmp/dotfiles

rpm-ostree override remove sassc inkscape optipng

# disabling the respositories for the booted system (since they'll be dealt with in image creation)
# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tofik-nwg-shell-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:manuelschneid3r.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/peterwu-rendezvous-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
