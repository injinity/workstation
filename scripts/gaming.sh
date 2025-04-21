#!/bin/bash

echo "Setting up the system for gaming.."

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-gaming" ]]; then
        echo "Option --no-gaming detected, skipping gaming setup."
        exit 0
    fi
done

# Install Steam
flatpak install -y com.valvesoftware.Steam

# Install Lutris
toolbox run -c injinity sudo dnf install -y wine python3-cairo gnome-terminal vulkan-tools pciutils fluidsynth gamemode
toolbox run -c injinity sudo dnf install -y lutris

# Export the lutris launcher so that it can
./scripts/subscripts/toolbox_export.sh lutris

