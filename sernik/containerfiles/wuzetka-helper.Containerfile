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

# Klassy
FROM fedora:${IMAGE_MAJOR_VERSION} as klassy

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/klassy.sh && \
    /tmp/build-scripts/klassy.sh

# Plasma Panel Colorizer
FROM fedora:${IMAGE_MAJOR_VERSION} as plasma-panel-colorizer

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/plasma-panel-colorizer.sh && \
    /tmp/build-scripts/plasma-panel-colorizer.sh

# Joystickwake
FROM fedora:${IMAGE_MAJOR_VERSION} as joystickwake

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/joystickwake.sh && \
    /tmp/build-scripts/joystickwake.sh

# Catppuccin
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin

# GTK Theme
COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-gtk.sh && \
    /tmp/build-scripts/catppuccin-gtk.sh

# Packages built with cargo/rust
FROM fedora:${IMAGE_MAJOR_VERSION} as cargo

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/cargo.sh && \
    /tmp/build-scripts/cargo.sh

# Packages built with go
FROM fedora:${IMAGE_MAJOR_VERSION} as go

COPY sernik/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/go.sh && \
    /tmp/build-scripts/go.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr/etc

COPY --from=go /tmp/go-built/usr /artifacts/usr
COPY --from=cargo /tmp/cargo-built/usr /artifacts/usr
COPY --from=catppuccin /tmp/catppuccin-gtk/usr /artifacts/usr
COPY --from=joystickwake /tmp/joystickwake-built/usr /artifacts/usr
COPY --from=plasma-panel-colorizer /tmp/panel-colorizer-built/usr /artifacts/usr
COPY --from=klassy /tmp/klassy-built/usr /artifacts/usr
COPY --from=burn-my-windows-kwin /tmp/burn-my-windows-built/usr /artifacts/usr
COPY --from=rounded-corners-kwin /tmp/rounded-corners-built/usr /artifacts/usr
