#!/bin/bash

# Path for debug file
DEBUG_FILE="/tmp/openvpn-debug-vars.txt"

# Clear previous debug file if it exists
echo "OpenVPN Environment Variables - Generated at $(date)" > "$DEBUG_FILE"
echo "==========================================================" >> "$DEBUG_FILE"

# Save script arguments
echo "Script Arguments:" >> "$DEBUG_FILE"
echo "script_type: $script_type" >> "$DEBUG_FILE"
echo "dev: $dev" >> "$DEBUG_FILE"
echo "" >> "$DEBUG_FILE"

# Save all OpenVPN-specific environment variables (common ones)
echo "OpenVPN Common Variables:" >> "$DEBUG_FILE"
echo "dev_type: $dev_type" >> "$DEBUG_FILE"
echo "tun_mtu: $tun_mtu" >> "$DEBUG_FILE"
echo "link_mtu: $link_mtu" >> "$DEBUG_FILE"
echo "ifconfig_local: $ifconfig_local" >> "$DEBUG_FILE"
echo "ifconfig_remote: $ifconfig_remote" >> "$DEBUG_FILE"
echo "route_gateway: $route_gateway" >> "$DEBUG_FILE"
echo "route_network_1: $route_network_1" >> "$DEBUG_FILE"
echo "route_netmask_1: $route_netmask_1" >> "$DEBUG_FILE"
echo "trusted_ip: $trusted_ip" >> "$DEBUG_FILE"
echo "trusted_port: $trusted_port" >> "$DEBUG_FILE"
echo "" >> "$DEBUG_FILE"

# Save all foreign options
echo "DNS/DHCP Options:" >> "$DEBUG_FILE"
for i in {1..20}; do
    var_name="foreign_option_$i"
    var_value=${!var_name}
    if [ -n "$var_value" ]; then
        echo "$var_name: $var_value" >> "$DEBUG_FILE"
    fi
done
echo "" >> "$DEBUG_FILE"

# Save complete route information
echo "Route Information:" >> "$DEBUG_FILE"
for i in {1..20}; do
    net_var="route_network_$i"
    mask_var="route_netmask_$i"
    gw_var="route_gateway_$i"

    net_val=${!net_var}
    mask_val=${!mask_var}
    gw_val=${!gw_var}

    if [ -n "$net_val" ]; then
        echo "Route $i: Network=$net_val, Netmask=$mask_val, Gateway=$gw_val" >> "$DEBUG_FILE"
    fi
done
echo "" >> "$DEBUG_FILE"

# Save all environment variables
echo "All Environment Variables:" >> "$DEBUG_FILE"
env | sort >> "$DEBUG_FILE"

# Add permissions info for reference
echo "" >> "$DEBUG_FILE"
echo "Script execution information:" >> "$DEBUG_FILE"
echo "Running as user: $(id)" >> "$DEBUG_FILE"
echo "Script permissions: $(ls -la $0)" >> "$DEBUG_FILE"
echo "resolv.conf permissions: $(ls -la /etc/resolv.conf)" >> "$DEBUG_FILE"

echo "Debug information saved to $DEBUG_FILE"
exit 0
