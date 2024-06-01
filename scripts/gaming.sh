# Install Steam
flatpak install -y com.valvesoftware.Steam

# Install Lutris
toolbox run sudo dnf update -y
toolbox run sudo dnf upgrade -y
toolbox run sudo dnf install -y wine python3-cairo gnome-terminal vulkan-tools pciutils fluidsynth gamemode
toolbox run sudo dnf install -y lutris
