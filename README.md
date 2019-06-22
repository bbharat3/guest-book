# guest-book

`2 nodes of DS1_v2 type is used.
one node is for running single replica of each component of demo app and required components of k8s
second node is for HA and extending the support for hpa.
`
# Assumptions
1. User is logged in with az-cli
2. CPU utilization for hpa is 10%

# Pre-requisites
1. Azure kubernetes cluster should be available.
2. helm should be installed.
3. Az-cli should be available. 
4. kubectl is configured.

# Create Cluster:
`make create_cluster`

# Create namespaces
`kubectl apply -f staging-namespace.yaml production-namespace.yaml`

# Create ingress
`make create_ingress`

# Deploy guestbook app with ingress and hpa
`make allinone`

# Deploy Horizontal pod autoscaler
`kubectl apply -f frontend-hpa.yaml`

# Load Testing
For increasing load many tools can be used like jmeter.
I have used a traditional approach which includes creating of a pod with busybox image and executing the below command

`while true; do wget -q -O- http://<cluster ip>:<port>;done`

# Notes
Helm is used as the package manager to deploy nginx ingress since it deploys all the required components for ingress as a package and interacts with underlying cloud provider to create a load balancer for the same

For monitoring, I believe prometheus can be used to get time-series data and monitoring how the container is performing.

Further, I believe the install istio will help more to manage k8s cluster and also the application in a better manner.
Some of its features includes all the required addon for monitoring, networking, management, canary deployment etc.


# Level 2

# Pre-requisites
1. Azure kubernetes cluster should be available.
2. helm should be installed.

# Installing Helm
    curl -L https://git.io/get_helm.sh | bash; helm init

    The above command will install helm and install  tiller to intract with kubernetes cluster

# Deploy guest-book app
   `make guestbook`

# Deploy EFK stack 
   `make EFK`

# Deploy Prometheus
   `make prometheus`

# Deploy Grafana
   `make grafana`


# Configuring  Jenkins instance on VM
   `curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo; \
   sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key; yum install -y jenkins; service jenkins start`

   Url: http://<host IP>:8080/

# Pre-requisites for integration with kubernetes
1. kubernetes plugin should be installed
2. config file should be copied to /var/lib/jenkins/.kube/ directory
3. Execute `helm init --client-only`
4. copy .helm directory in home directory of jenkins

# Deploy to k8s using jenkins 

1. create free-style job.
2. select check box for paramaterized build
3. Create two string parameters (package, namespace)
4. In Build step select 'execute shell' and add below command.
   `helm repo update;helm install stable/${package} --namespace ${namespace}`

Once the above build is successful it will install the package and assign a random name to the components.


   


