#!/usr/bin/env bash

# https://devopscube.com/install-configure-helm-kubernetes/
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

sudo kubectl create namespace gitlab

# https://docs.gitlab.com/charts/installation/deployment.html#deploy-using-helm
# because we are too lazy for a domain, we use wildcard DNS nip.io https://nip.io/
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab \
  -n gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain=10.11.1.150.nip.io \
  --set global.hosts.externalIP=10.11.1.150 \
  --set certmanager-issuer.email=hsmits@student.codam.nl \
  --set postgresql.image.tag=13.6.0 \
  --set global.edition=ce \
  --timeout 600s

# https://docs.gitlab.com/charts/installation/deployment.html#monitoring-the-deployment
# Monitoring the Deployment
# This will output the list of resources installed once the deployment finishes which may take 5-10 minutes.
# The status of the deployment can be checked by running helm status gitlab which can also be done while the deployment is taking place if you run the command in another terminal.

sudo kubectl wait --for=condition=available deployments --all -n gitlab

# Initial login
# You can access the GitLab instance by visiting the domain specified during installation. The default domain would be gitlab.example.com, unless the global host settings were changed. If you manually created the secret for initial root password, you can use that to sign in as root user. If not, GitLab would’ve automatically created a random password for root user. This can be extracted by the following command (replace <name> by name of the release - which is gitlab if you used the command above).
# sudo kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo
