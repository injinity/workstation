#!/bin/bash

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-injinity" ]]; then
        echo "Option --no-injinity detected, skipping injinity setup."
        exit 0
    fi
done

echo "Setting up the system for using the Injinity platform.."

# ======================= System Config ======================= START 

mkdir -p ~/.bashrc.d
cp configs/bashrc ~/.bashrc.d/injinity-bashrc

# ======================= System Config ======================= END

# ======================= CLI applications ======================= START 

toolbox run -c injinity sudo dnf install -y kubectl envsubst

# Install flux CLI
# https://fluxcd.io/flux/cmd/#install-using-bash
toolbox run -c injinity sudo curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash

# Download the KUBECONFIG from server
toolbox run -c injinity mkdir -p ~/.kube

# ======================= CLI applications ======================= END

# ======================= SSH Config ======================= START 

# Set a local domain "master-node-0" and point it to the ip of the VPS
sudo ./scripts/subscripts/update_hosts.sh

sudo cp configs/ssh_config.conf /etc/ssh/ssh_config.d/0-injinity.conf
sudo systemctl restart sshd

# Add Injinity VPSs to known_hosts
mkdir -p ~/.ssh/known_hosts.d
cp configs/known_hosts ~/.ssh/known_hosts.d/injinity_known_hosts

# Copy connections scripts to ~/Nodes dir
mkdir -p ~/Nodes

cp configs/admin@master-node-0.sh ~/Nodes/admin@master-node-0.sh
chmod +x ~/Nodes/admin@master-node-0.sh

cp configs/dev@master-node-0.sh ~/Nodes/dev@master-node-0.sh
chmod +x ~/Nodes/dev@master-node-0.sh

# ======================= SSH Config ======================= END

# ======================= Systemd services ======================= START 

# Standard directory for systemd user services
mkdir -p ~/.config/systemd/user/

# Script executed on startup by `injinity-startup.service`
cp configs/startup-script.sh ~/.local/bin/injinity-startup-script.sh
chmod +x ~/.local/bin/injinity-startup-script.sh

# Oneshot Service executed once after system startup
cp configs/startup.service ~/.config/systemd/user/injinity-startup.service
systemctl --user enable --now injinity-startup.service

# Open SSH tunnel to Injinity VPS for remote kubectl use
cp configs/ssh-tunnel.service ~/.config/systemd/user/injinity-ssh-tunnel.service
systemctl --user enable --now injinity-ssh-tunnel.service

# ======================= Systemd services ======================= END

