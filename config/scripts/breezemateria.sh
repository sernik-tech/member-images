#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# NOTE: This script only works if with images that use plasma and/or have the breeze plasma theme installed.
# This copies the breeze desktop theme and replaces the breeze icons with materia/material's icons

# Create working directory
mkdir -p /tmp/breezemateriaworkingdir
git clone --depth=1 https://github.com/PapirusDevelopmentTeam/materia-kde /tmp/breezemateriaworkingdir/materia-kde
cp -r /usr/share/plasma/desktoptheme/default /tmp/breezemateriaworkingdir/breeze

# Delete original icons
rm -r /tmp/breezemateriaworkingdir/breeze/icons
rm -r /tmp/breezemateriaworkingdir/breeze/weather
rm /tmp/breezemateriaworkingdir/breeze/widgets/containment-controls.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/configuration-icons.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/arrows.svgz
rm /tmp/breezemateriaworkingdir/breeze/widgets/action-overlays.svgz
rm /tmp/breezemateriaworkingdir/breeze/metadata.json

# Compress Materia's svgs
gzip -S z /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/*/*.svg

# Copy icons from materia to breeze
cp -r /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/icons /tmp/breezemateriaworkingdir/breeze
cp -r /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/weather /tmp/breezemateriaworkingdir/breeze
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/containment-controls.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/configuration-icons.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/arrows.svgz /tmp/breezemateriaworkingdir/breeze/widgets
cp /tmp/breezemateriaworkingdir/materia-kde/plasma/desktoptheme/Materia-Color/widgets/action-overlays.svgz /tmp/breezemateriaworkingdir/breeze/widgets

# Download modified metadata files and copy to finish the product
wget https://git.gay/sneexy/sernik/raw/branch/main/kde/breeze-materia/template/metadata.desktop -O /tmp/breezemateriaworkingdir/breeze/metadata.desktop
mv /tmp/breezemateriaworkingdir/breeze /usr/share/plasma/desktoptheme/Breeze-Materia
