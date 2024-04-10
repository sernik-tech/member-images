ARG IMAGE_MAJOR_VERSION=40

# GTK Theme
FROM fedora:${IMAGE_MAJOR_VERSION} as gtk

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/burn-my-windows-kwin.sh && \
    /tmp/build-scripts/burn-my-windows-kwin.sh

# KDE Plasma
FROM fedora:${IMAGE_MAJOR_VERSION} as kde

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/rounded-corners-kwin.sh && \
    /tmp/build-scripts/rounded-corners-kwin.sh

# Icons (Papirus)

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc/skel/.local/share/themes
RUN mkdir -p /artifacts/usr/share/icons

COPY --from=gtk /tmp/kde-material-you-built/usr /artifacts/usr
COPY --from=kde /tmp/burn-my-windows-built/usr /artifacts/usr
COPY --from=icons /tmp/rounded-corners-built/usr /artifacts/usr
