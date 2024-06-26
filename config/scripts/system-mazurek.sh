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
#mkdir -p /usr/share/gnome-shell/extensions/paperwm@paperwm.github.com
mkdir -p /usr/share/gnome-shell/extensions/pip-on-top@rafostar.github.com
mkdir -p /usr/share/gnome-shell/extensions/dock-from-dash@fthx
mkdir -p /usr/share/gnome-shell/extensions/useless-gaps@pimsnel.com
mkdir -p /usr/share/gnome-shell/extensions/quick-settings-tweaks@qwreey
mkdir -p /usr/share/gnome-shell/extensions/unite@hardpixel.eu
mkdir -p /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com
mkdir -p /usr/share/gnome-shell/extensions/desktop-cube@schneegans.github.com
mkdir -p /usr/share/gnome-shell/extensions/compiz-alike-magic-lamp-effect@hermes83.github.com.zip
mkdir -p /usr/share/gnome-shell/extensions/compiz-windows-effect@hermes83.github.com
mkdir -p /usr/share/gnome-shell/extensions/pano@elhan.io
mkdir -p /usr/share/gnome-shell/extensions/Vitals@CoreCoding.com
mkdir -p /usr/etc/skel/.local/share/themes
mkdir -p /usr/etc/skel/.var/app/org.gnome.gedit/data/gedit/styles
mkdir -p /usr/etc/skel/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/themes

# Catppuccin GTK Theme
rpm-ostree install sassc inkscape optipng
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk
python3 -m venv /tmp/gtk/venv
source /tmp/gtk/venv/bin/activate && pip install -r /tmp/gtk/requirements.txt
cd /tmp/gtk && source /tmp/gtk/venv/bin/activate && python3 /tmp/gtk/install.py mocha -a green -s compact --tweaks float -d /usr/etc/skel/.local/share/themes
rpm-ostree override remove GraphicsMagick GraphicsMagick-c++ boost-atomic boost-filesystem flexiblas flexiblas-netlib flexiblas-openblas-openmp gsl gtksourceview4 inkscape inkscape-libs lib2geom libcdr libgfortran libquadmath librevenge libsass libvisio libwpd libwpg mkfontscale openblas openblas-openmp optipng potrace python3-cssselect python3-inkex python3-lxml python3-numpy python3-pyparsing python3-pyserial python3-scour python3-six sassc urw-base35-fonts-legacy

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

# PrismLauncher
git clone https://github.com/catppuccin/prismlauncher.git /tmp/prismlauncher
mv /tmp/prismlauncher/themes/* /usr/etc/skel/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/themes

# Configure bluez/bluetooth to not automatically enable itself
sed -i 's@#AutoEnable=true@AutoEnable=false@g' /etc/bluetooth/main.conf

# GNOME Extensions

# PiP on top (Source)
git clone https://github.com/Rafostar/gnome-shell-extension-pip-on-top.git /tmp/pipontop
chmod +x /tmp/pipontop/translate.sh
chmod +x /tmp/pipontop/bundle.sh
cd /tmp/pipontop && /tmp/pipontop/translate.sh
cd /tmp/pipontop && /tmp/pipontop/bundle.sh
unzip /tmp/pipontop/pip-on-top@rafostar.github.com.zip -d /usr/share/gnome-shell/extensions/pip-on-top@rafostar.github.com

# Dock from Dash (Source)
git clone https://github.com/fthx/dock-from-dash.git /tmp/dfd
rm -rf /tmp/dfd/README.md
cp -r /tmp/dfd/* /usr/share/gnome-shell/extensions/dock-from-dash@fthx

# Useless Gaps (Source)
git clone https://github.com/mipmip/gnome-shell-extensions-useless-gaps.git /tmp/uselessgaps
glib-compile-schemas --targetdir=/tmp/uselessgaps/src/schemas /tmp/uselessgaps/src/schemas
cd /tmp/uselessgaps && gnome-extensions pack src --force --podir="../po" --extra-source="ui.js" --extra-source="../LICENSE" --extra-source="../CHANGELOG.md"
unzip /tmp/uselessgaps/useless-gaps@pimsnel.com.shell-extension.zip -d /usr/share/gnome-shell/extensions/useless-gaps@pimsnel.com

# Quick Settings Tweaks (Source)
git clone https://github.com/qwreey/quick-settings-tweaks.git /tmp/qst
glib-compile-schemas --targetdir=/tmp/qst/src/schemas /tmp/qst/src/schemas
cd /tmp/qst && gnome-extensions pack src --extra-source=../LICENSE --extra-source=../LICENSE-gnome-volume-mixer --extra-source=features --extra-source=libs --extra-source=prefPages --extra-source=media --extra-source=contributors --podir=../po --force
unzip /tmp/qst/quick-settings-tweaks@qwreey.shell-extension.zip -d /usr/share/gnome-shell/extensions/quick-settings-tweaks@qwreey

# Pano (Releases)
curl -sL -o /tmp/pano.zip https://github.com/oae/gnome-shell-pano/releases/latest/download/pano@elhan.io.zip
unzip /tmp/pano.zip -d /usr/share/gnome-shell/extensions/pano@elhan.io

# Unite (Releases)
VER=$(curl --silent -qI https://github.com/hardpixel/unite-shell/releases/latest | awk -F '/' '/^location/ {print  substr($NF, 1, length($NF)-1)}'); \
curl -sL -o /tmp/unite.zip https://github.com/hardpixel/unite-shell/releases/download/${VER}/unite-${VER}.zip 
unzip /tmp/unite.zip -d /usr/share/gnome-shell/extensions/unite@hardpixel.eu
glib-compile-schemas --targetdir=/usr/share/gnome-shell/extensions/unite@hardpixel.eu/schemas /usr/share/gnome-shell/extensions/unite@hardpixel.eu/schemas

# PaperWM (Source)
#git clone https://github.com/paperwm/PaperWM.git /tmp/paperwm
#rm -rf /tmp/paperwm/.git
#rm -rf /tmp/paperwm/.github
#rm -rf /tmp/paperwm/.gitignore
#rm -rf /tmp/paperwm/.eslintrc.yml
#rm -rf /tmp/paperwm/media
#rm -rf /tmp/paperwm/README.md
#rm -rf /tmp/paperwm/CONTRIBUTING.md
#rm -rf /tmp/paperwm/install.sh
#rm -rf /tmp/paperwm/uninstall.sh
#cp -r /tmp/paperwm/* /usr/share/gnome-shell/extensions/paperwm@paperwm.github.com

# Desktop Cube (Releases)
curl -sL -o /tmp/desktopcube.zip https://github.com/Schneegans/Desktop-Cube/releases/latest/download/desktop-cube@schneegans.github.com.zip
unzip /tmp/desktopcube.zip -d /usr/share/gnome-shell/extensions/desktop-cube@schneegans.github.com
glib-compile-schemas --targetdir=/usr/share/gnome-shell/extensions/desktop-cube@schneegans.github.com/schemas /usr/share/gnome-shell/extensions/desktop-cube@schneegans.github.com/schemas

# Burn My Windows (Source)
git clone https://github.com/Schneegans/Burn-My-Windows.git /tmp/bmw
cd /tmp/bmw && make zip
unzip /tmp/bmw/burn-my-windows@schneegans.github.com.zip -d /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com
glib-compile-schemas --targetdir=/usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/schemas /usr/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/schemas

# Compiz alike magic lamp effect for GNOME Shell (Source)
git clone https://github.com/hermes83/compiz-alike-magic-lamp-effect.git /tmp/compiz-magic-lamp
chmod +x /tmp/compiz-magic-lamp/zip.sh
cd /tmp/compiz-magic-lamp && /tmp/compiz-magic-lamp/zip.sh
unzip /tmp/compiz-magic-lamp/compiz-alike-magic-lamp-effect@hermes83.github.com.zip -d /usr/share/gnome-shell/extensions/compiz-alike-magic-lamp-effect@hermes83.github.com

# Compiz windows effect (Source)
git clone https://github.com/hermes83/compiz-windows-effect.git /tmp/compiz-windows
rm -rf /tmp/compiz-windows/assets
rm -rf /tmp/compiz-windows/README.md
cp -r /tmp/compiz-windows/* /usr/share/gnome-shell/extensions/compiz-windows-effect@hermes83.github.com

# Wallpaper Slideshow (Source)
git clone https://gitlab.com/AndrewZaech/azwallpaper.git /tmp/azwall
cd /tmp/azwall && make zip-file
unzip /tmp/azwall/azwallpaper@azwallpaper.gitlab.com.zip -d /usr/share/gnome-shell/extensions/azwallpaper@azwallpaper.gitlab.com

# Vitals (Source)
git clone https://github.com/corecoding/Vitals.git /tmp/vitals
rm -rf /tmp/vitals/.git
rm -rf /tmp/vitals/.github
rm -rf /tmp/vitals/README.md
cp -r /tmp/vitals/* /usr/share/gnome-shell/extensions/Vitals@CoreCoding.com

# disabling the repositories for the booted system
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo
