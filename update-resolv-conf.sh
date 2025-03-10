#!/bin/bash

# Script to update resolv.conf with DNS settings from OpenVPN

[ "$script_type" ] || exit 0
[ "$dev" ] || exit 0

split_into_args() {
  echo "$@" | tr ' ' '\n'
}

case "$script_type" in
  up)
    NMSRVRS=$(split_into_args "$foreign_option_1 $foreign_option_2 $foreign_option_3" | grep "dhcp-option DNS" | cut -d' ' -f3)
    for NMSRVR in $NMSRVRS; do
      echo "nameserver $NMSRVR" >> /etc/resolv.conf
    done
    ;;
  down)
    # Restore the original resolv.conf
    if [ -f /etc/resolv.conf.backup ]; then
      cp /etc/resolv.conf.backup /etc/resolv.conf
    fi
    ;;
esac

exit 0
