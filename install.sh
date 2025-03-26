#!/bin/bash

sudo chmod +x scripts/*.sh scripts/subscripts/*.sh

./scripts/browser.sh "$@"
./scripts/general.sh "$@"
./scripts/programming.sh "$@"
./scripts/gaming.sh "$@"
./scripts/injinity.sh "$@"

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--nvidia" ]]; then
        echo "Option --nvidia detected, installing nvidia gpu drivers."
        ./scripts/nvidia_gpu_driers.sh
    fi
done

