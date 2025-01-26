#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo -e "You need to provide the name of the application you want to export to your host system as an argument.\n"
  echo -e "Usage: ./toolbox_export.sh <application_name>\n"
  exit 1
fi

# Use quotes around $1 to handle spaces in application names
app_name="$1"

# Find the desktop file associated with the application
desktop_file_to_export=$(find /usr/share/applications -iname "*$app_name*.desktop" 2>/dev/null)

# Find icons associated with the application
icons_to_export=$(find /usr/share/icons/hicolor/**/apps -iname "*$app_name*" 2>/dev/null)

# Check if any desktop files were found
if [ -z "$desktop_file_to_export" ]; then
  echo "No desktop file found for application: $app_name"
else
  echo -e "Exporting desktop file:\n$desktop_file_to_export\n"
  toolbox run mkdir -pv ~/.local/share/applications/
  toolbox run cp -v "$desktop_file_to_export" ~/.local/share/applications/

  # Path to the .desktop file
  DESKTOP_FILE="$HOME/.local/share/applications/lutris.desktop"

  # New Exec command
  NEW_EXEC="Exec=toolbox run lutris %U"

  # Use sed to replace the Exec line
  toolbox run sed -i "s|^Exec=.*|$NEW_EXEC|" "$DESKTOP_FILE"

  echo "Updated Exec line in $DESKTOP_FILE"
fi

# Check if any icons were found
if [ -z "$icons_to_export" ]; then
  echo "No icons found for application: $app_name"
else
  echo -e "Exporting icons:\n$icons_to_export\n"
  
  # Create necessary base directory in ~/.local/share/icons if it doesn't exist
  toolbox run mkdir -pv ~/.local/share/icons/hicolor
  
  # Copy icons while preserving their directory structure
  for icon in $icons_to_export; do
    # Get the directory path relative to /usr/share/icons/hicolor
    relative_path="${icon#/usr/share/icons/hicolor/}"
    # Create the target directory in ~/.local/share/icons
    target_dir="$(dirname "$relative_path")"
    toolbox run mkdir -pv "$HOME/.local/share/icons/hicolor/$target_dir"
    # Copy the icon to the new location
    toolbox run cp -v "$icon" "$HOME/.local/share/icons/hicolor/$target_dir/"
  done
fi

