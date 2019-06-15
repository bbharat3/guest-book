create_cluster: 
	az aks create -g aksCluster -n guestCluster --ssh-key-value ~/.ssh/aks_rsa.pub -s Standard_DS1_v2 -c 2 

# Required for creating load balancer 
create_ingress:
	helm install stable/nginx-ingress --name ingress --set controller.publishService.enabled=true    
	kubectl apply -f ./guest-book/ingress.yaml

install_guestbook:
	kubectl apply -f ./examples/guestbook/all-in-one/guestbook-all-in-one.yaml

frontend_hpa:
	kubectl apply -f ./guest-book/frontend-hpa.yaml

allinone:
	kubectl apply -f ./guest-book/all-in-one.yaml
	kubectl apply -f ./guest-book/ingress.yaml

