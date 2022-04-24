#!/bin/bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1  --bind-address=$1 --advertise-address=$1 "
curl -sfL https://get.k3s.io |  sh -
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/
sudo yum install net-tools -y

echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh