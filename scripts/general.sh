#!/bin/bash

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-common" ]]; then
        echo "Option --no-common detected, skipping common setup."
        exit 0
    fi
done

# Set mouse scroll directions to natural
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

# Install Flatseal
flatpak install -y flathub com.github.tchx84.Flatseal

# Install Signal
flatpak install -y org.signal.Signal

