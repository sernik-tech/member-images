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
FROM fedora:${IMAGE_MAJOR_VERSION} as icons

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/kde-material-you.sh && \
    /tmp/build-scripts/kde-material-you.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc
RUN mkdir -p /artifacts/sbin

COPY --from=kde-material-you /tmp/kde-material-you-built/usr /artifacts/usr
COPY --from=burn-my-windows-kwin /tmp/burn-my-windows-built/usr /artifacts/usr
COPY --from=rounded-corners-kwin /tmp/rounded-corners-built/usr /artifacts/usr
