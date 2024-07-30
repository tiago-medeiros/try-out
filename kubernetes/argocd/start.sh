#!/bin/bash

# Check if 'argocd' namespace exists and create it if not
if kubectl get namespaces argocd &> /dev/null; then
  echo "Namespace 'argocd' already exists."
else
kubectl create namespace argocd
  echo "Created namespace 'argocd'"
fi

# Update ArgoCD Helm repository before installing
if ! helm repo update argo/argo-cd; then
  helm repo add argo https://argoproj.github.io/argo-helm
  helm repo update argo/argo-cd
fi

# Install ArgoCD in the 'argocd' namespace using Helm
if ! helm install argocd argo/argo-cd -n argocd; then
  echo "Failed to update ArgoCD Helm repository. Ensure you have kubectl and helm installed."
  exit 1
fi

# Wait for the deployment to finish before exiting
kubectl wait --for=condition=ready -l app.kubernetes.io/name=argocd-server -n argocd


