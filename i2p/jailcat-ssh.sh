#!/bin/bash

REMOTE_HOST="server"

# Check and establish SSH tunnels if not already running
function ensure_tunnel {
    local PORT=$1
    if ! lsof -i TCP:$PORT | grep -q ssh; then
        echo "Opening SSH tunnel on port $PORT..."
        ssh -f -N -L $PORT:127.0.0.1:$PORT "$REMOTE_HOST"
    else
        echo "Tunnel on port $PORT already active."
    fi
}

ensure_tunnel 7657  # I2P Router Console
ensure_tunnel 4444  # I2P HTTP Proxy

sleep 1

# Launch IceCat inside Firejail with I2P proxy settings
firejail --profile="$HOME/.config/firejail/icecat-i2p.profile" icecat --new-window "$@"

