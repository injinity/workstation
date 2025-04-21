#!/bin/bash

echo "Setting up the browser.."

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-browser" ]]; then
        echo "Option --no-browser detected, skipping browser setup."
        exit 0
    fi
done

# Install Brave browser and set it as default
flatpak install -y com.brave.Browser
xdg-settings set default-web-browser com.brave.Browser.desktop

# Hiding the default browser (Firefox)
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_hiding_the_default_browser_firefox
echo "Hiding the default browser (firefox).."
sudo mkdir -p /usr/local/share/applications/

sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop

sudo update-desktop-database /usr/local/share/applications/

