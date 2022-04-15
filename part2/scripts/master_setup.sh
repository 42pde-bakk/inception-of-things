#!/usr/bin/env bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $1 --node-ip $1 --flannel-iface=eth1"
curl -sfL https://get.k3s.io |  sh -

echo "alias k='k3s kubectl'" >> /etc/profile.d/00-aliases.sh

sudo yum install net-tools -y

/usr/local/bin/kubectl create configmap app1-html --from-file /vagrant/kubernetes/app1/index.html
/usr/local/bin/kubectl apply -f /vagrant/kubernetes/app1/deployment-svc.yaml

/usr/local/bin/kubectl create configmap app2-html --from-file /vagrant/confs/k3s/app2/index.html
/usr/local/bin/kubectl apply -f /vagrant/kubernetes/app2/deployment-svc.yaml

/usr/local/bin/kubectl create configmap app3-html --from-file /vagrant/confs/k3s/app3/index.html
/usr/local/bin/kubectl apply -f /vagrant/kubernetes/app3/deployment-svc.yaml

/usr/local/bin/kubectl apply -f /vagrant/kubernetes/ingress.yaml
