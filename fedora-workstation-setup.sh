#!/bin/bash

# Install Brave browser and set it as default
flatpak install -y com.brave.Browser
xdg-settings set default-web-browser com.brave.Browser.desktop

# Hiding the default browser (Firefox)
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_hiding_the_default_browser_firefox
mkdir -p /usr/local/share/applications/
cp /usr/share/applications/firefox.desktop /usr/local/share/applications/
sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/firefox.desktop
update-desktop-database /usr/local/share/applications/

# Set mouse scroll directions to natural
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

# Install Flatseal
flatpak install -y flathub com.github.tchx84.Flatseal

# Install Intelij IDEA CE
flatpak install -y com.jetbrains.IntelliJ-IDEA-Community

# Install Steam
flatpak install -y com.valvesoftware.Steam

# Install Spotify
flatpak install -y com.spotify.Client

# Install Signal
flatpak install -y org.signal.Signal

# Install Lutris
toolbox create -y
toolbox run sudo dnf update -y
toolbox run sudo dnf upgrade -y
toolbox run sudo dnf install -y wine python3-cairo gnome-terminal vulkan-tools pciutils fluidsynth
toolbox run sudo dnf install -y lutris
