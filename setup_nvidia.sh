#!/bin/bash

# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_enabling_rpm_fusion_repos
rpm-ostree install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
reboot
