
#  PODS ----------------------------------------------------------------------------------------------------------------
apply_pods:
	kubectl apply -f web/pod.yml

get_pods:
	kubectl get pods

get_all:
	kubectl get all

del_web_pods:
	kubectl delete pod web

logs_web:
	 kubectl logs web

#  DEPLOYMENTS ---------------------------------------------------------------------------------------------------------
apply_web_deployment:
	kubectl apply -f web/deployment.yml

delete_web_deployment:
	kubectl delete deployment web-deployment

delete_api_deployment:
	kubectl delete deployment api-deployment

delete_web_service:
	kubectl delete service web-service

delete_api_service:
	kubectl delete service api-service

delete_all:
	kubectl delete all --all

#  Node Port -----------------------------------------------------------------------------------------------------------
#  +----------+       +----------+       +----------+
#  |   WWW    | <-->  | NodePort | <-->  |   Pod    |
#  +----------+       +----------+       +----------+
apply_web_node_port_service:
	make apply_web_deployment
	kubectl apply -f web/service.yml

test_web_node_port:
	curl http://localhost:30001

apply_api_node_port-deployment:
	kubectl apply -f api/node-port-deployment.yml

test_api_node_port:
	curl http://localhost:30002


#  Cluster IP ----------------------------------------------------------------------------------------------------------
# +----------+       +----------+       +-----------+       			+------------+
# |   WWW    | <-->  | NodePort | <-->  |   Pods    | <- Cluster IP ->  |    Pods    |
# +----------+       +----------+       |   (API)   |       			| (Database) |
#                                       +-----------+       			+------------+
apply_mongo_deployment:
	kubectl apply -f mongo/deployment.yml

get_mongo_pvc:
	kubectl get pvc

# Connect by DNS (service)
# connect_string = "mongo://mongo-service"

apply_mongo_pvc:
	kubectl apply -f mongo/persistent-volume-claim.yml

# Ingress (Load Balancer) ----------------------------------------------------------------------------------------------
# +----------+       					+----------+       	+-----------+       			+------------+
# |   WWW    | <- Ingress Controller -> | Custer IP | <-->  |   Pods    | <- Cluster IP ->  |    Pods    |
# +----------+       					+----------+       	|   (API)   |       			| (Database) |
#                                       					+-----------+       			+------------+
# Ingress Controller: https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
# Install: kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
apply_ingress:
	kubectl apply -f ingress/ingress.yml

get_ingress:
	kubectl get ingress

# mapping domain web.com
# sudo nano /etc/hosts
# 127.0.0.1 web.com

test_by_ingress:
	curl http://web.com
	curl http://web.com/api