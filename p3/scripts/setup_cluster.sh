#!/usr/bin/env bash

RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
MAGENTA=$'\e[1;35m'
CYN=$'\e[1;36m'
END=$'\e[0m'

echo "${GREEN}Creating cluster${END}"
CLUSTER_NAME=vela
k3d cluster create $CLUSTER_NAME --port 8080:80@loadbalancer --port 8443:443@loadbalancer --port 8888:8888@loadbalancer

kubectl get jobs -n kube-system
echo "${CYN}Waiting for jobs in namespace kube-system to finish${END}"
kubectl -n kube-system wait --for=condition=complete jobs/helm-install-traefik jobs/helm-install-traefik-crd --timeout=-1s
kubectl get jobs -n kube-system

echo "${GREEN}Done waiting for jobs in kube-system${END}"
# References:
# https://surenraju.medium.com/setup-your-personal-kubernetes-cluster-with-k3s-and-k3d-7979976cde5
# https://www.techmanyu.com/setup-a-gitops-deployment-model-on-your-local-development-environment-with-k3s-k3d-and-argocd-4be0f4f30820
