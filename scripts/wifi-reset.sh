#!/usr/bin/env bash
# ~/nix-home-mgr/scripts/wifi-reset.sh
# Reset the Wi-Fi adapter using NetworkManager

set -euo pipefail

iface="${1:-}"

# Try to auto-detect the Wi-Fi interface if not given
if [[ -z "$iface" ]]; then
    iface="$(nmcli device status | awk '$2=="wifi" {print $1; exit}')"
fi

if [[ -z "$iface" ]]; then
    echo "Could not find a Wi-Fi interface. Use: $0 <interface>"
    exit 1
fi

echo "Restarting Wi-Fi interface: $iface"
nmcli device disconnect "$iface"
sleep 1
nmcli device connect "$iface"
echo "Wi-Fi $iface reset."

