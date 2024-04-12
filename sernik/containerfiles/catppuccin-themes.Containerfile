ARG IMAGE_MAJOR_VERSION=40

#
# Catppuccin
#
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin

# GTK Theme
COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-gtk.sh && \
    /tmp/build-scripts/catppuccin-gtk.sh

# KDE Theme
COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-plasma.sh && \
    /tmp/build-scripts/catppuccin-plasma.sh

# Icons
# NOTE: Original Papirus icons are required, so copy those to your image as well.
COPY sernik/build-scripts/themes/catppuccin /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-papirus.sh && \
    /tmp/build-scripts/catppuccin-papirus.sh

# Finalize image
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/share/themes && \
    mkdir -p /artifacts/usr/share/icons && \
    mkdir -p /artifacts/usr/share/color-schemes && \
    mkdir -p /artifacts/usr/share/aurorae/themes && \
    mkdir -p /artifacts/usr/share/plasma/look-and-feel

COPY --from=catppuccin /tmp/catppuccin-gtk/usr /artifacts/usr
COPY --from=catppuccin /tmp/catppuccin-kde/usr /artifacts/usr
COPY --from=catppuccin /tmp/catppuccin-papirus/usr /artifacts/usr

RUN echo "Inside /artifacts/usr/share/themes:" && \
    ls /artifacts/usr/share/themes && \
    echo && \
    echo "Inside /artifacts/usr/share/icons:" && \
    ls /artifacts/usr/share/icons && \
    echo && \
    echo "Inside /artifacts/usr/share/color-schemes:" && \
    ls /artifacts/usr/share/color-schemes && \
    echo && \
    echo "Inside /artifacts/usr/share/aurorae/themes:" && \
    ls /artifacts/usr/share/aurorae/themes && \
    echo && \
    echo "Inside /artifacts/usr/share/plasma/look-and-feel:" && \
    ls /artifacts/usr/share/plasma/look-and-feel
