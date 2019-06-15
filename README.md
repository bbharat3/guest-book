# guest-book

# Pre-requisites
1. Azure kubernetes cluster should be available.
2. helm should be installed.
3. Az-cli should be available. 
4. kubectl is configured.

# Create Cluster:
make create_cluster

# Create namespaces
kubectl apply -f staging-namespace.yaml production-namespace.yaml

# Create ingress
make create_ingress

# Deploy guestbook app with ingress and hpa
make allinone

# Deploy Horizontal pod autoscaler
kubectl apply -f frontend-hpa.yaml

