#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Bazzite
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite.repo"
wget "https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-$(rpm -E %fedora)/kylegospo-bazzite-multilib-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo"

# bazzite packages
rpm-ostree install joystickwake xwiimote-ng

# systemd services to enable on the system
systemctl start hblock.timer

# Ensure all required/used folders are created
mkdir -p /usr/share/sddm/themes
mkdir -p /usr/share/kwin/effects
mkdir -p /usr/share/plasma/plasmoids/org.kde.latte.spacer
mkdir -p /usr/share/themes
mkdir -p /usr/share/icons
mkdir -p /usr/etc/skel/.local/share/themes
mkdir -p /usr/etc/skel/.local/share/konsole

#
# Sheldon
#
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to /usr/bin

#
# Krabby
#
KRABBY_VER=$(curl -sL https://api.github.com/repos/yannjor/krabby/releases/latest | jq -r '.assets[] | select(.name? | match("krabby-.*-x86_64.tar.gz$")) | .browser_download_url')
curl -sL -o /tmp/krabby.tar.gz ${KRABBY_VER}
tar -xvf /tmp/krabby.tar.gz -C /tmp
cp /tmp/krabby /usr/bin
chmod +x /usr/bin/krabby

#
# wgcf
#
WGCF_VER=$(curl -sL https://api.github.com/repos/ViRb3/wgcf/releases/latest | jq -r '.assets[] | select(.name? | match("wgcf_.*_linux_amd64$")) | .browser_download_url')
curl -sL -o /usr/bin/wgcf ${WGCF_VER}
chmod +x /usr/bin/wgcf

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
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1 # Mocha Green (dark)
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1 # Latte Green (light)

#
# Custom Plasma Theme
#
mkdir -p /tmp/breezemateriaworkingdir
git clone --depth=1 https://github.com/PapirusDevelopmentTeam/materia-kde /tmp/breezemateriaworkingdir/materia-kde
cp -r /usr/share/plasma/desktoptheme/default /tmp/breezemateriaworkingdir/breeze
# delete files
rm -r /tmp/breezemateriaworkingdir/breeze/icons
rm -r /tmp/breezemateriaworkingdir/breeze/weather
rm /tmp/breezemateriaworkingdir/breeze/widgets/containment-controls.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/configuration-icons.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/arrows.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/action-overlays.svgz
rm /tmp/breezemateriaworkingdir/breeze/metadata.json
# compress materia's svgs
gzip -S z /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/*/*.svg
# copy icons from materia to breeze
cp -r /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/icons /tmp/breezemateriaworkingdir/breeze
cp -r /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/weather /tmp/breezemateriaworkingdir/breeze
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/containment-controls.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/configuration-icons.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/arrows.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/action-overlays.svgz /tmp/breezemateriaworkingdir/breeze/widgets
# download modified metadata files and copy to finish the product
wget https://git.gay/sneexy/sernik/raw/branch/main/kde/breeze-materia/template/metadata.desktop -O /tmp/breezemateriaworkingdir/breeze/metadata.desktop
mv /tmp/breezemateriaworkingdir/breeze /usr/share/plasma/desktoptheme/Breeze-Materia

#
# Konsole
#
git clone https://github.com/catppuccin/konsole /tmp/konsole
cp -r /tmp/konsole/*.colorscheme /usr/etc/skel/.local/share/konsole

#
# GTK Theme
#
rpm-ostree install sassc inkscape optipng
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk # Clone the GTK theme repository
python3 -m venv /tmp/gtk # Create python virtual environment
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact -d /usr/etc/skel/.local/share/themes

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
# Latte spacer
#
git clone https://github.com/psifidotos/applet-latte-spacer.git /tmp/latte-spacer
# plasma 6 git, might be unneeded later
#git clone https://github.com/doncsugar/applet-latte-spacer.git /tmp/latte-spacer
rm -rf /tmp/latte-spacer/.git
rm -f /tmp/latte-spacer/README.md
rm -f /tmp/latte-spacer/CHANGELOG.md
cp -r /tmp/latte-spacer/* /usr/share/plasma/plasmoids/org.kde.latte.spacer

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
# Panel Colorizer
#
#rpm-ostree install libplasma plasma5support
#git clone git clone https://github.com/luisbocanegra/plasma-panel-colorizer /tmp/panel-colorizer
#cd /tmp/panel-colorizer && cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr
#cd /tmp/panel-colorizer && cmake --build build
#cd /tmp/panel-colorizer && cmake --install build

#
# Clean up
#

# remove deps installed from building packages and stuff from source
# gtk deps
rpm-ostree override remove GraphicsMagick GraphicsMagick-c++ flexiblas flexiblas-netlib flexiblas-openblas-openmp gsl gtksourceview4 inkscape inkscape-libs lib2geom libcdr libgfortran libquadmath librevenge libsass libvisio libwpd libwpg mkfontscale openblas openblas-openmp optipng potrace python3-cssselect python3-inkex python3-lxml python3-numpy python3-pyparsing python3-pyserial python3-scour python3-six sassc urw-base35-fonts-legacy
# qt deps
rpm-ostree override remove cmake cmake-data extra-cmake-modules jsoncpp kf5-kauth-devel kf5-kcodecs-devel kf5-kconfig-devel kf5-kconfigwidgets-devel kf5-kcoreaddons-devel kf5-kservice-devel kf5-kwindowsystem-devel kf5-rpm-macros kwin-devel libX11-devel libXau-devel libepoxy-devel libglvnd-core-devel libglvnd-devel libxcb-devel mesa-libEGL-devel qt5-qtbase-devel qt5-linguist qt5-rpm-macros vulkan-loader-devel xorg-x11-proto-devel gettext-devel kf5-kwidgetsaddons-devel

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/kylegospo-rom-properties-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/home:paul4us.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
