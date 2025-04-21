#!/bin/bash

echo "Setting up the common system configuration.."

# Set mouse scroll directions to natural
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

# Install Flatseal
flatpak install -y flathub com.github.tchx84.Flatseal

# Install Signal
flatpak install -y org.signal.Signal

# ============= Setting up toolbox =================

# Get the host Fedora version
host_version=$(rpm -E %fedora)
echo "Host Fedora version: $host_version"

# Get the image ID of the container
image_id=$(podman inspect "injinity" --format '{{.ImageID}}')
echo "Injinity containers image_id: $image_id"

# Extract the image's Fedora version from the labels (if available)
fedora_version=$(podman image inspect "$image_id" \
    --format '{{ index .Labels "version" }}')
echo "Injinity containers fedora image version: $fedora_version"

if (( fedora_version < host_version )); then
    echo "Removing outdated container: $container"
    podman stop injinity
    toolbox rm injinity
    toolbox rmi $image_id
    toolbox create -y injinity
else
    echo "Container is up to date: $container"
fi

toolbox run -c injinity sudo dnf update -y
toolbox run -c injinity sudo dnf upgrade -y

# ============= Setting up toolbox =================
