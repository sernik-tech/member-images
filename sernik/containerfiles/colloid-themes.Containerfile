ARG IMAGE_MAJOR_VERSION=40

#
# Colloid
#
FROM fedora:${IMAGE_MAJOR_VERSION} as colloid

# GTK Theme
COPY sernik/build-scripts/themes/colloid /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/colloid-gtk.sh && \
    /tmp/build-scripts/colloid-gtk.sh

# KDE Theme
COPY sernik/build-scripts/themes/colloid /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/colloid-plasma.sh && \
    /tmp/build-scripts/colloid-plasma.sh

# Icons
COPY sernik/build-scripts/themes/colloid /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/colloid-icons.sh && \
    /tmp/build-scripts/colloid-icons.sh

#
# Jasper
#

#
# Tela
#

FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc/skel/.local/share/themes && \
    mkdir -p /artifacts/usr/share/icons && \
    mkdir -p /artifacts/usr/share/color-schemes && \
    mkdir -p /artifacts/usr/share/aurorae/themes && \
    mkdir -p /artifacts/usr/share/plasma/look-and-feel

COPY --from=colloid /tmp/colloid-gtk/usr /artifacts/usr
COPY --from=colloid /tmp/colloid-kde/usr /artifacts/usr
COPY --from=colloid /tmp/colloid-icons/usr /artifacts/usr

RUN echo "Inside /artifacts/usr/etc/skel/.local/share/themes:" && \
    ls /artifacts/usr/etc/skel/.local/share/themes && \
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
