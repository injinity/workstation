#!/bin/bash

# https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_using_nvidia_drivers
rpm-ostree install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
reboot
