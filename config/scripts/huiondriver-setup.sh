#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

echo "Starting installation procedure..."

INSTALL_PATH="/tmp/huion-driver"

mkdir -p $INSTALL_PATH
cd $INSTALL_PATH

echo "Set current working directory to $(pwd)"
echo "Downloading and unpacking the driver..."

wget -c "https://driverdl.huion.com/driver/Linux/HuionTablet_v15.0.0.89.202205241352.x86_64.tar.xz" -O - | tar -xJv

if [ -e "$INSTALL_PATH/install.sh" ] && [ -e "$INSTALL_PATH/uninstall.sh" ] && [ -d "$INSTALL_PATH/huion" ]; then
    echo "Installation files exist! Continuing..."
else
    echo "Could not find files required to install the driver. Aborting"
    exit 1
fi

echo "Running install script..."

exec ./install.sh
wait

echo "The driver should be installed successfully!"
