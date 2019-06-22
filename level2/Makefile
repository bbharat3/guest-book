EFK:
	helm install stable/elasticsearch --name elasticsearch --namespace logging --values elasticsearch.values.yaml
	helm install stable/fluentd --name fluentd --namespace logging--values fluentd.values.yaml
	helm install stable/kibana --name kibana --namespace logging --values kibana.values.yaml

grafana:
	helm install stable/grafana --name grafana --namespace monitoring --values grafana.values
	
prometheus:
	helm install stable/prometheus --name prometheus --namespace monitoring --values prometheus.values.yaml

guestbook:
	helm install guestbook/.