#!/usr/bin/env bash
# ~/nix-home-mgr/scripts/screenshot.sh
# Take a screenshot and save to ~/Pictures

set -euo pipefail

out="$HOME/Pictures/Screenshot-$(date '+%Y%m%d-%H%M%S').png"
if command -v gnome-screenshot >/dev/null 2>&1; then
    gnome-screenshot -f "$out"
    echo "Screenshot saved to $out"
else
    echo "gnome-screenshot not found."
fi

