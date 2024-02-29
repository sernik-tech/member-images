#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# regenerate systemd units & enable post-install service
systemctl daemon-reload
systemctl enable mazurek-post-setup.service
