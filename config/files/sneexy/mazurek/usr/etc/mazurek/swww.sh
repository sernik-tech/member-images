#!/usr/bin/env bash

set -oue pipefail

# Slightly modified version of
# https://github.com/LGFae/swww/blob/main/example_scripts/swww_randomize.sh

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=75
export SWWW_TRANSITION_STEP=90
export SWWW_TRANSITION=center

# This controls (in seconds) when to switch to the next image
INTERVAL=1800

while true; do
	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img"
			sleep $INTERVAL
		done
done
