#!/usr/bin/env bash

RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
MAGENTA=$'\e[1;35m'
CYN=$'\e[1;36m'
END=$'\e[0m'

echo "${GREEN}Installing Docker${END}" # https://www.fosslinux.com/49959/install-docker-on-debian.htm
sudo apt update -y
sudo apt install -y man git curl wget
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
docker --version


echo "${GREEN}Installing k3d${END}" # https://k3d.io/v5.4.1/
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d --version

echo "${GREEN}Installing kubectl${END}" # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm -f kubectl
echo "alias k=kubectl" >> ~/.bashrc
