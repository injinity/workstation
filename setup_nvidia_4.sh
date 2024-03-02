#!/bin/bash

# Get the driver version in X-X-X format
DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | sed 's/\./-/g')

flatpak install -y org.freedesktop.Platform.GL.nvidia-"$DRIVER_VERSION"
flatpak install -y org.freedesktop.Platform.GL32.nvidia-"$DRIVER_VERSION"
