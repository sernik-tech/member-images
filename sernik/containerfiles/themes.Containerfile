ARG IMAGE_MAJOR_VERSION=40

#
# Catppuccin
#

# GTK Theme
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin-gtk

COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-gtk.sh && \
    /tmp/build-scripts/catppuccin-gtk.sh

# KDE Theme
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin-kde

COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-plasma.sh && \
    /tmp/build-scripts/catppuccin-plasma.sh

# Icons
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin-icons

COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-papirus.sh && \
    /tmp/build-scripts/catppuccin-papirus.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc/skel/.local/share/themes && \
    mkdir -p /artifacts/usr/share/icons && \
    mkdir -p /artifacts/usr/share/color-schemes && \
    mkdir -p /artifacts/usr/share/aurorae/themes && \
    mkdir -p /artifacts/usr/share/plasma/look-and-feel

COPY --from=catppuccin-gtk /tmp/catppuccin-gtk /artifacts/usr/etc/skel/.local/share/themes
COPY --from=catppuccin-kde /tmp/catppuccin-kde/usr /artifacts/usr
COPY --from=catppuccin-icons /tmp/catppuccin-papirus/usr /artifacts/usr

RUN ls /artifacts/usr/etc/skel/.local/share/themes && \
    ls /artifacts/usr/share/icons && \
    ls /artifacts/usr/share/color-schemes && \
    ls /artifacts/usr/share/aurorae/themes && \
    ls /artifacts/usr/share/plasma/look-and-feel
