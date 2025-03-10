#!/bin/bash
set -e

# Validate that VPN_CONFIG_FILE is provided
if [ -z "$VPN_CONFIG_FILE" ]; then
    echo "Error: VPN_CONFIG_FILE environment variable is required"
    exit 1
fi

# Check if the VPN config file exists
if [ ! -f "/vpn/$VPN_CONFIG_FILE" ]; then
    echo "Error: VPN config file /vpn/$VPN_CONFIG_FILE not found"
    exit 1
fi

# Backup original resolv.conf
cp /etc/resolv.conf /etc/resolv.conf.backup

# Enable IP forwarding
#echo "Enabling IP forwarding"
#echo 1 > /proc/sys/net/ipv4/ip_forward

# Start OpenVPN
echo "Starting OpenVPN with config /vpn/$VPN_CONFIG_FILE"
exec openvpn --config "/vpn/$VPN_CONFIG_FILE" --script-security 2
