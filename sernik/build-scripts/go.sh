#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y golang
mkdir -p /tmp/go-built/usr/bin
go env -w GOBIN=/tmp/go-built/usr/bin

cd /tmp

# cod - https://github.com/dim-an/cod
git clone https://github.com/dim-an/cod.git
cd cod
go build
go install