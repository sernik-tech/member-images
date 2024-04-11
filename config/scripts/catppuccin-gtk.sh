#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
FLAVOUR=mocha
ACCENT=green
GTKDIR=/usr/etc/skel/.local/share/themes

# Create theme directory
mkdir -p /usr/etc/skel/.local/share/themes

# Dependencies to create theme
rpm-ostree install sassc inkscape optipng
# Clone repository into /tmp/gtk
git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk
# Python setup
python3 -m venv /tmp/gtk # Create python virtual environment
source /tmp/gtk/bin/activate && pip install -r /tmp/gtk/requirements.txt
# Create theme and install to user directory
# Add `-s compact` after `-a $ACCENT` for compact version of theme
cd /tmp/gtk && source /tmp/gtk/bin/activate && python3 /tmp/gtk/install.py $FLAVOUR -a $ACCENT -s compact -d $GTKDIR

# Remove all of the dependencies installed
rpm-ostree override remove GraphicsMagick GraphicsMagick-c++ flexiblas flexiblas-netlib flexiblas-openblas-openmp gsl gtksourceview4 inkscape inkscape-libs lib2geom libcdr libgfortran libquadmath librevenge libsass libvisio libwpd libwpg mkfontscale openblas openblas-openmp optipng potrace python3-cssselect python3-inkex python3-lxml python3-numpy python3-pyparsing python3-pyserial python3-scour sassc urw-base35-fonts-legacy
