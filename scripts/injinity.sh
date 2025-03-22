#!/bin/bash

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-injinity" ]]; then
        echo "Option --no-injinity detected, skipping injinity setup."
        exit 0
    fi
done

toolbox run sudo dnf install kubectl

# Install flux CLI
# https://fluxcd.io/flux/cmd/#install-using-bash
toolbox run sudo curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash

# Add autocompletion to the flux command
# https://fluxcd.io/flux/cmd/flux_completion_bash/#examples
# ~/.bashrc or ~/.profile
toolbox run echo "command -v flux >/dev/null && . <(flux completion bash)" | sudo tee -a ~/.bashrc


