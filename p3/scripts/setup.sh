
echo "Installing Docker" # https://www.fosslinux.com/49959/install-docker-on-debian.htm
sudo apt update -y
sudo apt install man git curl wget -y
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io
docker --version
# sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# apt-cache policy docker-ce
# sudo apt install docker-ce -y

echo "Installing k3d" # https://k3d.io/v5.4.1/
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Installing kubectl" # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Creating cluster"
CLUSTER_NAME=vela
k3d cluster create $CLUSTER_NAME #--api-port 6443 -p 8080:80@loadbalancer --agents 2
k3d kubeconfig get $CLUSTER_NAME > k3d_config


echo "Installing Argo CD"
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f ../confs/deployment-argocd.yaml
kubectl apply -f ../confs/deployment-wil.yaml
