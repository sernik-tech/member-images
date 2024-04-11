ARG IMAGE_MAJOR_VERSION=40

# Burn my windows (KWin)
FROM fedora:${IMAGE_MAJOR_VERSION} as burn-my-windows-kwin

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/burn-my-windows-kwin.sh && \
    /tmp/build-scripts/burn-my-windows-kwin.sh

# Rounded corners (KWin)
FROM fedora:${IMAGE_MAJOR_VERSION} as rounded-corners-kwin

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/rounded-corners-kwin.sh && \
    /tmp/build-scripts/rounded-corners-kwin.sh

# Klsasy
FROM fedora:${IMAGE_MAJOR_VERSION} as klassy

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/klassy.sh && \
    /tmp/build-scripts/klassy.sh

# KDE Material You Colors
FROM fedora:${IMAGE_MAJOR_VERSION} as kde-material-you

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/kde-material-you.sh && \
    /tmp/build-scripts/kde-material-you.sh

# Joystickwake
FROM fedora:${IMAGE_MAJOR_VERSION} as joystickwake

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/joystickwake.sh && \
    /tmp/build-scripts/joystickwake.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc

COPY --from=joystickwake /tmp/joystickwake-built/usr /artifacts/usr
COPY --from=kde-material-you /tmp/kde-material-you-built/usr /artifacts/usr
COPY --from=klassy /tmp/klassy-built/usr /artifacts/usr
COPY --from=burn-my-windows-kwin /tmp/burn-my-windows-built/usr /artifacts/usr
COPY --from=rounded-corners-kwin /tmp/rounded-corners-built/usr /artifacts/usr
