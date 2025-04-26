#!/bin/bash

# Sync the remote KUBECONFIG with the local one on startup
toolbox run -c injinity scp dev@master-node-0:~/.kube/config ~/.kube/config

