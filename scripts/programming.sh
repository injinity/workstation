#!/bin/bash

echo "Setting the system up for programming.."

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-programming" ]]; then
        echo "Option --no-programming detected, skipping programming setup."
        exit 0
    fi
done

# Set the default git branch to main globally
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

# Install Intelij IDEA CE
flatpak install -y com.jetbrains.IntelliJ-IDEA-Community

