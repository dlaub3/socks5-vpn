#!/bin/bash
set -e

# Validate that VPN_CONFIG_FILE is provided
if [ -z "$VPN_CONFIG_FILE" ]; then
    echo "Error: VPN_CONFIG_FILE environment variable is required"
    exit 1
fi

# Check if the VPN config file exists
if [ ! -f "$VPN_CONFIG_FILE" ]; then
    echo "Error: VPN config file $VPN_CONFIG_FILE not found"
    exit 1
fi

# Backup original resolv.conf
cp /etc/resolv.conf /etc/resolv.conf.backup

# Start OpenVPN
echo "Starting OpenVPN with config $VPN_CONFIG_FILE"
exec openvpn --config "$VPN_CONFIG_FILE" --script-security 2
