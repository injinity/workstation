# Set mouse scroll directions to natural
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

toolbox create -y

# Install Flatseal
flatpak install -y flathub com.github.tchx84.Flatseal

# Install Signal
flatpak install -y org.signal.Signal
