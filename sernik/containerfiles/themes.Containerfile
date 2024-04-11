ARG IMAGE_MAJOR_VERSION=40

#
# Catppuccin
#

# GTK Theme
FROM fedora:${IMAGE_MAJOR_VERSION} as gtk

COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-gtk.sh && \
    /tmp/build-scripts/catppuccin-gtk.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc/skel/.local/share/themes && \
    mkdir -p /artifacts/usr/share/icons

COPY --from=gtk /tmp/catppuccin-gtk /artifacts/usr/etc/skel/.local/share/themes

RUN ls /artifacts/usr/etc/skel/.local/share/themes && \
    ls /artifacts/usr/share/icons
