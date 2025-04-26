#!/bin/bash

# Define variables
HOSTS_FILE="/etc/hosts"
MARKER_START="# INJINITY HOSTS BEGIN"
MARKER_END="# INJINITY HOSTS END"
NEW_CONTENT_FILE="configs/hosts"

# Check if the new content file exists
if [[ ! -f "$NEW_CONTENT_FILE" ]]; then
  echo "Error: $NEW_CONTENT_FILE not found."
  exit 1
fi

# Ensure the script is run with appropriate permissions
if [[ ! -w "$HOSTS_FILE" ]]; then
  echo "Error: Insufficient permissions to modify $HOSTS_FILE."
  echo "Please run the script with sudo or as root."
  exit 1
fi

# Backup the original hosts file
cp "$HOSTS_FILE" "${HOSTS_FILE}.bak"

# Check if the markers exist
if grep -qF "$MARKER_START" "$HOSTS_FILE" && grep -qF "$MARKER_END" "$HOSTS_FILE"; then
  # Markers exist; replace the content between them
  sed -e "/$MARKER_START/,/$MARKER_END/{//!d}" "$HOSTS_FILE" | \
  sed -e "/$MARKER_START/r $NEW_CONTENT_FILE" > "${HOSTS_FILE}.tmp"
else
  # Markers don't exist; append the new section at the end
  {
    cat "$HOSTS_FILE"
    echo ""
    echo "$MARKER_START"
    cat "$NEW_CONTENT_FILE"
    echo "$MARKER_END"
    echo ""
  } > "${HOSTS_FILE}.tmp"
fi

# Replace the original hosts file with the updated one
mv "${HOSTS_FILE}.tmp" "$HOSTS_FILE"

echo "The /etc/hosts file has been updated successfully."

