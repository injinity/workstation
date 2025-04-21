#!/bin/bash

# Define valid options (short and/or long)
VALID_OPTIONS=("--nvidia" "--no-browser" "--no-gaming" "--no-injinity" "--no-neovim" "--no-programming")

# Function to check if an item is in the list
is_valid_option() {
  local opt="$1"
  for valid in "${VALID_OPTIONS[@]}"; do
    if [[ "$opt" == "$valid" ]]; then
      return 0
    fi
  done
  return 1
}

# Loop over all provided arguments
for arg in "$@"; do
  if ! is_valid_option "$arg"; then
    echo "Invalid option: $arg"
    exit 1
  fi
done

echo "All options are valid."

echo "Installing the workstation setup.."

sudo chmod +x scripts/*.sh scripts/subscripts/*.sh

./scripts/common.sh "$@"
./scripts/browser.sh "$@"
./scripts/programming.sh "$@"
./scripts/gaming.sh "$@"
./scripts/injinity.sh "$@"
./scripts/neovim.sh "$@"

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--nvidia" ]]; then
        echo "Option --nvidia detected, installing nvidia gpu drivers."
        ./scripts/nvidia_gpu_driers.sh
    fi
done

