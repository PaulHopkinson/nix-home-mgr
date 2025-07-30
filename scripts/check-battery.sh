#!/usr/bin/env bash
# ~/nix-home-mgr/scripts/check-battery.sh
# Show battery status (acpi) and TLP battery info

set -euo pipefail

echo "=== Battery status (acpi -b) ==="
if command -v acpi >/dev/null 2>&1; then
    acpi -b
else
    echo "acpi not found."
fi

echo
echo "=== Battery details (tlp-stat -b) ==="
if command -v tlp-stat >/dev/null 2>&1; then
    tlp-stat -b
else
    echo "tlp-stat not found."
fi

