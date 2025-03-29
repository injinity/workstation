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
toolbox run echo 'source <(kubectl completion bash)' >> ~/.bashrc

# Install flux CLI
# https://fluxcd.io/flux/cmd/#install-using-bash
toolbox run sudo curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash

# Add autocompletion for flux CLI
# https://fluxcd.io/flux/cmd/flux_completion_bash/#examples
# ~/.bashrc or ~/.profile
toolbox run echo "command -v flux >/dev/null && . <(flux completion bash)" | sudo tee -a ~/.bashrc

# Set a local domain "master-node-0" and point it to the ip of the VPS
echo "62.169.17.115\tmaster-node-0" | sudo tee -a /etc/hosts

sudo cp ../configs/0-ssh_config.conf /etc/ssh/ssh_config.d/

# Ssh tunnel to the master-node-0
echo "ssh -fNL 6443:127.0.0.1:6443 dev@master-node-0" >> ~/.bashrc

# Download the KUBECONFIG from server
toolbox run scp dev@master-node-0:~/.kube/config .kube/config

# Create connection script and store it in the ~/Nodes dir
mkdir -p ~/Nodes
touch ~/Nodes/dev@master-node-0.sh
echo -e '#!/bin/bash\n\nssh dev@master-node-0' > ~/Nodes/dev@master-node-0.sh
chmod +x ~/Nodes/dev@master-node-0.sh

touch ~/Nodes/admin@master-node-0.sh
echo -e '#!/bin/bash\n\nssh admin@master-node-0' > ~/Nodes/admin@master-node-0.sh
chmod +x ~/Nodes/admin@master-node-0.sh

CERT_AUTHORITY=$(cat ../configs/known_hosts)

sed -i "/@cert-authority master-node-0/c\\$CERT_AUTHORITY" ~/.ssh/known_hosts

