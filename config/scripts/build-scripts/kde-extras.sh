#!/usr/bin/env bash

#
# This script mass builds multiple plasma, kwin and other types of extensions for the wuzetka image.
#
# Klassy ~ https://github.com/paulmcauley/klassy
# KDE Rounded Corners ~ https://github.com/matinlotfali/KDE-Rounded-Corners
# Plasma Panel Colorizer ~ https://github.com/luisbocanegra/plasma-panel-colorizer
# Burn My Windows dependencies ~ https://github.com/Schneegans/Burn-My-Windows
# Overview Widget for Plasma ~ https://github.com/HimDek/Overview-Widget-for-Plasma
# Latte Separator ~ https://github.com/doncsugar/applet-latte-separator
# Window Title Applet ~ https://github.com/dhruv8sh/plasma6-window-title-applet
# plasma-applet-netspeed-widget ~ https://github.com/dfaust/plasma-applet-netspeed-widget
# PlasMusic Toolbar ~ https://github.com/ccatterina/plasmusic-toolbar
# Desktop Indicator for Plasma 6 ~ https://github.com/dhruv8sh/plasma6-desktop-indicator


# Tell build process to exit if there are any errors.
set -euo pipefail

# Create directory where all compiled things go into
mkdir -p /tmp/kde-extras-built

#
# Dependencies
#
dnf install -y git gcc-c++ cmake git-clang-format clang-devel extra-cmake-modules gettext kwin-devel kf6-kconfigwidgets-devel libepoxy-devel kf6-kcmutils-devel qt6-qtbase-private-devel wayland-devel libplasma-devel plasma5support-devel kf6-kwidgetsaddons-devel zip unzip "cmake(KF5Config)" "cmake(KF5CoreAddons)" "cmake(KF5FrameworkIntegration)"  "cmake(KF5GuiAddons)" "cmake(KF5Kirigami2)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(Qt5DBus)" "cmake(Qt5Quick)" "cmake(Qt5Widgets)" "cmake(Qt5X11Extras)" "cmake(KDecoration2)" "cmake(KF6ColorScheme)" "cmake(KF6Config)" "cmake(KF6CoreAddons)" "cmake(KF6FrameworkIntegration)" "cmake(KF6GuiAddons)" "cmake(KF6I18n)" "cmake(KF6KCMUtils)" "cmake(KF6KirigamiPlatform)" "cmake(KF6WindowSystem)" "cmake(Qt6Core)" "cmake(Qt6DBus)" "cmake(Qt6Quick)" "cmake(Qt6Svg)" "cmake(Qt6Widgets)" "cmake(Qt6Xml)"

# Directories
mkdir -p /tmp/kde-extras-built/usr/share/kwin/effects
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoid

#
# Klassy
#
cd /tmp
git clone https://github.com/paulmcauley/klassy.git
cd klassy
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make -j$(nproc)
make install DESTDIR=/tmp/kde-extras-built PREFIX='/usr'

#
# KDE Rounded Corners
#
cd /tmp
git clone --single-branch --depth=1 https://github.com/matinlotfali/KDE-Rounded-Corners.git
cd KDE-Rounded-Corners
mkdir build
cd build
cmake .. --install-prefix /usr
make
make install DESTDIR=/tmp/kde-extras-built PREFIX='/usr'

#
# Burn My Windows
#
cd /tmp
git clone --single-branch --depth=1 https://github.com/Schneegans/Burn-My-Windows.git
cd Burn-My-Windows/kwin
chmod +x build.sh
./build.sh
tar -zvxf burn_my_windows_kwin4.tar.gz -C /tmp/kde-extras-built/usr/share/kwin/effects --no-same-owner --no-same-permissions

#
# Smart Video Wallpaper Reborn
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/luisbocanegra.smart.video.wallpaper.reborn
cd /tmp
git clone https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn.git
cd plasma-smart-video-wallpaper-reborn
sed -i 's@~/.local@/tmp/kde-extras-built/usr@g' /tmp/plasma-smart-video-wallpaper-reborn/install.sh
chmod +x install.sh
./install.sh

#
# Plasma Panel Colorizer
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer
cd /tmp
git clone --single-branch --depth=1 https://github.com/luisbocanegra/plasma-panel-colorizer.git
cd plasma-panel-colorizer
chmod +x package-plasmoid.sh
./package-plasmoid.sh
unzip plasmoid-panel-colorizer-v*.plasmoid -d /tmp/kde-extras-built/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer

#
# Compact Pager
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/com.github.tilorenz.compact_pager
cd /tmp
git clone https://github.com/tilorenz/compact_pager.git
cd compact_pager
chmod +x bundle.sh
./bundle.sh
unzip package.plasmoid -d /tmp/kde-extras-built/usr/share/plasma/plasmoids/com.github.tilorenz.compact_pager

#
# Overview Widget
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/com.himdek.kde.plasma.overview
cd /tmp
git clone https://github.com/HimDek/Overview-Widget-for-Plasma.git
cd Overview-Widget-for-Plasma
make overview
unzip overview.plasmoid -d /tmp/kde-extras-built/usr/share/plasma/plasmoids/com.himdek.kde.plasma.overview

#
# Latte Separator
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
cd /tmp
git clone https://github.com/doncsugar/applet-latte-separator.git -b plasma6
cd applet-latte-separator
mv contents /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
mv LICENSE /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
mv metadata.json /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator

#
# Window Title Applet
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
cd /tmp
git clone https://github.com/dhruv8sh/plasma6-window-title-applet.git
cd plasma6-window-title-applet
mv contents /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
mv LICENSE /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
mv metadata.json /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle

#
# plasma-applet-netspeed-widget
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.netspeedWidget
cd /tmp
git clone https://github.com/dfaust/plasma-applet-netspeed-widget.git
cd plasma-applet-netspeed-widget
mv ./package/* /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.netspeedWidget

#
# PlasMusic Toolbar
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/plasmusic-toolbar
cd /tmp
git clone https://github.com/ccatterina/plasmusic-toolbar.git
cd plasmusic-toolbar
mv ./src/* /tmp/kde-extras-built/usr/share/plasma/plasmoids/plasmusic-toolbar

#
# Desktop Indicator
#
mkdir -p /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
cd /tmp
git clone https://github.com/dhruv8sh/plasma6-desktop-indicator.git
cd plasma6-desktop-indicator
mv contents /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
mv LICENSE /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
mv metadata.json /tmp/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
