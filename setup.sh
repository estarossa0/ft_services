#!/bin/bash



if [[ $1 == "prune" ]]; then
{
	kubectl delete -k ./srcs
	docker rmi -f mysql_image:latest phpmyadmin_image:latest wordpress_image:latest nginx_image:latest grafana_image:latest influxdb_image:latest ftps_image:latest
	minikube delete
}
else
{
	minikube start --memory 3000
	eval $(minikube -p minikube docker-env)
	KUBEIP=$(minikube ip)
	EXERNALIP="192.168.99.240"
	docker build -t nginx_image ./srcs/nginx --build-arg URLIP=$KUBEIP --build-arg EXTIP=$EXERNALIP
	docker build -t wordpress_image ./srcs/wordpress --build-arg URLIP=$KUBEIP
	docker build -t phpmyadmin_image ./srcs/phpmyadmin --build-arg URLIP=$KUBEIP
	docker build -t mysql_image ./srcs/mysql --build-arg URLIP=$KUBEIP
	docker build -t grafana_image ./srcs/grafana --build-arg URLIP=$KUBEIP
	docker build -t influxdb_image ./srcs/influxdb --build-arg URLIP=$KUBEIP
	docker build -t ftps_image ./srcs/ftps --build-arg URLIP=$KUBEIP
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f ./srcs/config.yaml
	kubectl apply -k ./srcs/
	minikube dashboard &
	open -na "Google Chrome" --args -incognito http://$EXERNALIP
}
fi