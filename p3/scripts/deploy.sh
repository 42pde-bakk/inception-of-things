#!/usr/bin/env bash

RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
MAGENTA=$'\e[1;35m'
CYN=$'\e[1;36m'
END=$'\e[0m'

echo "${GREEN}Creating namespaces [argocd, dev]${END}"
kubectl create namespace argocd
kubectl create namespace dev

echo "${GREEN}Applying ArgoCD${END}"
kubectl apply -n argocd -f ../confs/argocd-install.yaml

echo "${CYN}Let's wait for all pods to be ready"
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=-1s

echo "${GREEN}Applying Ingress${END}"
kubectl apply -n argocd -f ../confs/ingress.yaml

echo "${GREEN}Applying Deployment-Wil${END}"
kubectl apply -f ../confs/deployment-wil.yaml

echo "${CYN}Let's wait for all pods in dev to be ready${END}"
kubectl wait --for=condition=Ready pods --all -n dev --timeout=-1s

echo "${RED}Admin password:${END}"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

echo "${GREEN}Let's curl Wil's playground${END}"
curl http://localhost:8888/
