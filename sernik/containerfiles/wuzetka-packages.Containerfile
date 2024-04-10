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

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc
RUN mkdir -p /artifacts/sbin

COPY --from=burn-my-windows-kwin /tmp/burn-my-windows-built/usr /artifacts/usr
COPY --from=rounded-corners-kwin /tmp/rounded-corners-built/usr /artifacts/usr
