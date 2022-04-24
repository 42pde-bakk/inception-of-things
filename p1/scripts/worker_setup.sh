#!/bin/bash

export TOKEN_FILE="/vagrant/scripts/node-token"
export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"
curl -sfL https://get.k3s.io | sh -
sudo yum install net-tools -y
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh
