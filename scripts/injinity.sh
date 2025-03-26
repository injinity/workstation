#!/bin/bash

# Loop through all arguments
for arg in "$@"; do
    if [[ "$arg" == "--no-injinity" ]]; then
        echo "Option --no-injinity detected, skipping injinity setup."
        exit 0
    fi
done

toolbox run sudo dnf install kubectl

# Add autocompletion for kubectl CLI
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion
toolbox run echo 'source <(kubectl completion bash)' >>~/.bashrc

# Install flux CLI
# https://fluxcd.io/flux/cmd/#install-using-bash
toolbox run sudo curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash

# Add autocompletion for flux CLI
# https://fluxcd.io/flux/cmd/flux_completion_bash/#examples
# ~/.bashrc or ~/.profile
toolbox run echo "command -v flux >/dev/null && . <(flux completion bash)" | sudo tee -a ~/.bashrc

# Set a local domain "vps1.contabo-0" and point it to the ip of the VPS
echo "62.169.17.115\tvps1.contabo-0" | sudo tee -a /etc/hosts

# Ssh tunnel to the master-node-0
ssh -i $HOME/.ssh/dev.vps1.contabo-0 -fNL 6443:127.0.0.1:6443 dev@vps1.contabo-0

# Download the KUBECONFIG from server
toolbox run scp -i $HOME/.ssh/dev.vps1.contabo-0 dev@vps1.contabo-0:/etc/rancher/rke2/rke2.yaml .kube/config

mkdir ~/Nodes
touch ~/Nodes/vps1.contabo-0.sh
echo -e '#!/bin/bash\n\nssh -i $HOME/.ssh/dev.vps1.contabo-0 dev@vps1.contabo-0' > ~/Nodes/dev.vps1.contabo-0.sh
sudo chmod +x ~/Nodes/dev.vps1.contabo-0.sh

