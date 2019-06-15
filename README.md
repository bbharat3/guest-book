# guest-book

2 nodes of DS1_v1 type is used.
one node is for running single replica of each component of demo app and required components of k8s
second node is for HA and extending the support for hpa.

# Assumptions
1. User is logged in with az-cli
2. CPU utilization for hpa is 10%

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

# Load Testing
For increasing load many tools can be used like jmeter.
I have used a traditional approach which includes creating of a pod with busybox image and executing the below command

`while true; do wget -q -O- http://<cluster ip>:<port>;done`

# Notes
Helm is used as the package manager to deploy nginx ingress since it deploys all the required components for ingress as a package and interacts with underlying cloud provider to create a load balancer for the same

For monitoring, I believe prometheus can be used to get time-series data and monitoring how the container is performing.

Further, I believe the install istio will help more to manage k8s cluster and also the application in a better manner.
Some of its features includes all the required addon for monitoring, networking, management, canary deployment etc.
