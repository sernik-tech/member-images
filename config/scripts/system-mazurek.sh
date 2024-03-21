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
# rpm-ostree override remove kitty

#
# create all required folders for the following setup
#
mkdir -p /etc/mazurek
mkdir -p /etc/skel/.config/nvim
mkdir -p /etc/skel/.local/share/icons
mkdir -p /etc/skel/.local/share/themes
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /usr/share/qt5ct/colors
mkdir -p /usr/share/qt6ct/colors
mkdir -p /usr/share/backgrounds/catppuccin

#
# Catppuccin
#
FLAVOUR=mocha
ACCENT_COLOR=green

#
# GTK Theme
#

# Install dependencies
# Only required for creating the GTK theme, if you use any of these packages for your system and/or preinstall them,
# remove installing and uninstalling the packages you use from this script
rpm-ostree install sassc inkscape optipng

git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk # Clone the GTK theme repository
python3 -m venv /tmp/gtk # Create python virtual environment
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt # Install python dependencies within the virtual environment
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /usr/share/themes # Install the theme system-side (May not be required for your own use-case)
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /etc/skel/.local/share/themes # Install the theme for users (only for fresh installs and new users)
# NOTE: You can specify `-s compact` for a more compact version of the GTK theme to be installed.
# For example: python3 /tmp/gtk/install.py ${FLAVOUR} -a ${ACCENT_COLOR} -s compact -d /usr/share/themes

#
# QT(5/6CT) Theme
#
# WIP: May be replaced with kvantum

git clone https://github.com/ItsEthra/qt5ct.git /tmp/qt5ct # Clone the QT repository (A fork used with a fix as the original repo is inactive)
cp /tmp/qt5ct/themes/* /usr/share/qt5ct/colors # Copy themes for QT5
cp /tmp/qt5ct/themes/* /usr/share/qt6ct/colors # Copy themes for QT6

#
# Papirus (Folders)
#

# Clone the script & copy the contents to the installed icons.
# Reminder: This means that this script has to run after installing packages.
# Make sure you are installing the `papirus-icon-theme` package.
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus # Copy the custom files to Papirus
chmod +x /tmp/papirus-folders/papirus-folders # Making the script executable
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-${FLAVOUR}-${ACCENT_COLOR} # Change the color of the icon theme using papirus-folders

#
# Dotfiles
#

# clone dotfiles manually from repo and copy them to /etc/skel for user dotfiles
git clone https://git.gay/sneexy/mazurek-dots.git /tmp/dotfiles
cp -rf /tmp/dotfiles/etc/* /etc
cp -rf /tmp/dotfiles/config/* /etc/skel/.config
cp -rf /tmp/dotfiles/local/* /etc/skel/.local
cp -rf /tmp/dotfiles/icons/* /usr/share/icons
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
#rm -rf /usr/libexec/sddm-compositor-sway # SDDM configurations provided by sddm-wayland-sway, we only keep the package as it provides a properly configured SDDM user and setup.
#rm -rf /usr/lib/sddm/sddm.conf.d/wayland-sway.conf
#rm -rf /usr/share/sddm/themes/03-sway-fedora
#rm -rf /etc/sway

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
