#!/bin/bash

# Hiding the default browser (Firefox)
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_hiding_the_default_browser_firefox
mkdir -p /usr/local/share/applications/
cp /usr/share/applications/firefox.desktop /usr/local/share/applications/
sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/firefox.desktop
update-desktop-database /usr/local/share/applications/

# Set mouse scroll directions to natural
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
