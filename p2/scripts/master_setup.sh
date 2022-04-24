#!/usr/bin/env bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $1 --node-ip $1 --flannel-iface=eth1"
curl -sfL https://get.k3s.io |  sh -

echo "alias k='k3s kubectl'" >> /etc/profile.d/00-aliases.sh

sudo yum install net-tools -y

/usr/local/bin/kubectl apply -f /vagrant/confs/app1.yaml
/usr/local/bin/kubectl apply -f /vagrant/confs/app2.yaml
/usr/local/bin/kubectl apply -f /vagrant/confs/app3.yaml
/usr/local/bin/kubectl apply -f /vagrant/confs/ingress.yaml
