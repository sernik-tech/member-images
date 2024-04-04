#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Bazzite
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# bazzite packages
rpm-ostree install joystickwake xwiimote-ng

# Ensure all required/used folders are created
mkdir -p /usr/share/sddm/themes
mkdir -p /usr/share/kwin/effects
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /etc/skel/.local/share/themes

#
# KDE Theme
#
rpm-ostree install gettext-devel
git clone https://github.com/catppuccin/kde.git /tmp/catppuccinkde
cd /tmp/catppuccinkde && git checkout v0.2.5 # Comment when Fedora 40/Plasma 6
rm -f /tmp/catppuccinkde/install.sh
#curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/sernik/catppuccin-kde/install.sh
curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sernik-tech/member-images/main/sernik/catppuccin-kde/install-kde5.sh # Comment when Fedora 40/Plasma 6
chmod +x /tmp/catppuccinkde/install.sh
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1

#
# GTK Theme
#

# Install dependencies
rpm-ostree install sassc inkscape optipng

git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk # Clone the GTK theme repository
python3 -m venv /tmp/gtk # Create python virtual environment
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact -d /etc/skel/.local/share/themes

#
# Papirus (Folders)
#
git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-mocha-green

#
# SDDM Theme
#
git clone https://github.com/aczw/sddm-theme-corners.git /tmp/corners
sudo cp -r /tmp/corners/corners /usr/share/sddm/themes

#
# KDE Rounded Corners
#
rpm-ostree install git cmake gcc-c++ extra-cmake-modules kwin-devel kf5-kconfigwidgets-devel libepoxy-devel
git clone https://github.com/matinlotfali/KDE-Rounded-Corners.git /tmp/roundedcorners
mkdir /tmp/roundedcorners/build
cd /tmp/roundedcorners/build && cmake .. --install-prefix /usr
cd /tmp/roundedcorners/build && make && make install

#
# Burn My Windows
#
rpm-ostree install kf5-kwidgetsaddons-devel
git clone https://github.com/Schneegans/Burn-My-Windows.git /tmp/bmw
chmod +x /tmp/bmw/kwin/build.sh
cd /tmp/bmw && /tmp/bmw/kwin/build.sh
tar -xf /tmp/bmw/kwin/burn_my_windows_kwin4.tar.gz -C /usr/share/kwin/effects

#
# Clean up
#

# remove deps installed from building packages and stuff from source
# gtk deps
rpm-ostree override remove GraphicsMagick GraphicsMagick-c++ flexiblas flexiblas-netlib flexiblas-openblas-openmp gsl gtksourceview4 inkscape inkscape-libs lib2geom libcdr libgfortran libquadmath librevenge libsass libvisio libwpd libwpg mkfontscale openblas openblas-openmp optipng potrace python3-cssselect python3-inkex python3-lxml python3-numpy python3-pyparsing python3-pyserial python3-scour python3-six sassc urw-base35-fonts-legacy
# qt deps
rpm-ostree override remove cmake cmake-data extra-cmake-modules jsoncpp kf5-kauth-devel kf5-kcodecs-devel kf5-kconfig kf5-kconfig-devel kf5-kconfigwidgets-devel kf5-kcoreaddons-devel kf5-kservice-devel kf5-kwindowsystem-devel kf5-rpm-macros kwin-devel libX11-devel libXau-devel libepoxy-devel libglvnd-core-devel libglvnd-devel libxcb-devel mesa-libEGL-devel qt5-qtbase-devel qt5-linguist qt5-rpm-macros rhash vulkan-headers vulkan-loader-devel xorg-x11-proto-devel gettext-devel kf5-kwidgetsaddons-devel

# kill the files
rm -rf /tmp/catppuccinkde
rm -rf /tmp/gtk
rm -rf /tmp/papirus-folders
rm -rf /tmp/corners
rm -rf /tmp/roundedcorners
rm -rf /tmp/bmw

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
