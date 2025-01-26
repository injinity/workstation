#!/bin/bash

sudo chmod +x scripts/*.sh scripts/subscripts/*.sh

./scripts/browser.sh
./scripts/general.sh
./scripts/programming.sh
./scripts/gaming.sh

if [ "$1" = "+nvidia_gpu_driers" ]; then
  ./scripts/nvidia_gpu_driers.sh
fi
