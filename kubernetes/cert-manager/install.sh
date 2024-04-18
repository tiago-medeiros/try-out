helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update

# Install CRDs (Custom Resources Definitions)
# kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.crds.yaml

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set installCRDs=true
